import prisma from "../config/PrismaClient.js";
import { secretKey } from "../config/generateSecretKey.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import * as location from "./LocationController.js";


export const getUsers = async (req, res) => {
  try {

    const users = await prisma.user.findMany({
      select: {
          user_id: true,
          user_uuid: true,
          full_name: true,
          username: true,
          email: true,
          type: true,
          organization_name: true,
          organization_type: true,
          organization_contact_info: true,
          contact_address: true,
          contact_phone: true,
          is_active: true,
          created_at: true,
          location_id: true
      }
  });

    if (!users) return res.status(404).send({ message: "Nenhum usuário encontrado" });
    
    res.json(users);
    
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};


export const getUserById = async (req, res) => {
  try {
        
        const user_id = parseInt(req.params.id);

        const user = await prisma.user.findUnique({ where: { user_id} });
      
        if (!user) return res.status(404).send({ message: "Nenhum usuário encontrado" });
        
        res.json(user);
      
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const registerUser = async (req, res) => {
  try {
    const { full_name, username, email, password, confPassword, type, organization_name, 
      organization_type, organization_contact_info, contact_address, 
      contact_phone, district_id } = req.body;

      const optionalFields = ['organization_name', 'organization_type', 'organization_contact_info', 'contact_address', 'contact_phone'];

    if (!full_name || !username || !email || !password || !confPassword || !type)
      return res.status(400).send({ message: "Preencha todos os campos obrigatórios" });

    if (password !== confPassword)
      return res.status(400).json({ message: "As palavras-passe não coincidem" });

    const salt = await bcrypt.genSalt(10);
    const hashPwd = await bcrypt.hash(password, salt);

    //create the location based on the district provided and get location id returned
    const location_id = await location.createLocationByDistrict(parseInt(district_id));

    
    const data = {full_name, username, email, password: hashPwd, type, location_id};

    // Include optional fields in the data object if provided in the request body
    for (const field of optionalFields) {
      if (req.body[field] !== undefined) {
        data[field] = req.body[field];
      }
    }
    
    const user = createUser(data);

      if(!user) return res.json({ message: "Erro na criação do usuário", success: false});

        return res.json({
          message: "Usuário registado com sucesso",
          success: true,
          data: data,
        });  
    
         } catch (error) {
            res.status(500).send(error);
          }
        };

  export const createUser = async (data) => {
      try {
              return await prisma.user.create({data});
        
        } catch (error) {
          console.error(error);
          throw error;
        }
    };
        

export const updateUser = async (req, res) => {

// Define an array of sensitive fields that should not be updated
  const sensitiveFields = ['user_id', 'username', 'user_uuid', 'email', 'created_at'];

  try {
    const user_id = parseInt(req.params.id);
    let userData = req.body; 

    // Exclude sensitive fields from the userData object
    userData = Object.fromEntries(
      Object.entries(userData).filter(([key]) => !sensitiveFields.includes(key))
    );

    // Check if at least one non-sensitive field is provided for update
    if (Object.keys(userData).length === 0) {
      return res.status(400).json({ message: "Deve ser fornecido pelo menos um campo para atualização"});
    }

    // Hash the new password if provided
    if (userData['password']) {      
        const salt = await bcrypt.genSalt(10);
        const hashPwd = await bcrypt.hash(userData['password'], salt);
      
        userData['password'] = hashPwd;
    }

    // Update user in the database
    const updatedUser = await prisma.user.update({
      where: {user_id},
      data: userData, 
    });
    
    res.status(200).json({message: "Usuário atualizado com sucesso", success: true, data: updatedUser});

  } catch (error) {
    res.status(500).send(error);
  }
};


export const deleteUser = async (req, res) => {
  try {
    const user_id = parseInt(req.params.id); 

    await prisma.user.delete({
      where: {user_id},
    });

    res.status(204).end();
  } catch (error) {
    res.status(500).send(error);
  }
};


export const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password)
      return res.status(400).send({ message: "E-mail ou senha inválido" });

    const user = await prisma.user.findUnique({ 
      where: { email },   
      select: {
        user_id: true,
        full_name: true,
        email: true,
        password: true,
        type: true,
        organization_name: true,
        organization_type: true,
        is_active: true
    } });
    
    if (!user)
      return res.status(404).send({ message: "E-mail não encontrado" });

    const isMatched = await bcrypt.compare(password, user.password);
    if (!isMatched) return res.status(401).send({ message: "Palavra-passe incorreta" });

    const tokenExpiration = Math.floor((Date.now() + (1 * 60 * 60 * 1000)) / 1000);

    const token = jwt.sign({ email }, secretKey, {
      expiresIn: '1h',
    });

    return res
      .cookie("userToken", token, {
        httpOnly: true,
        maxAge: 24 * 60 * 60 * 1000,
      })
      .json({ message: "Login bem-sucedido!", success: true , user: user, tokenExpiration: tokenExpiration});
  } catch (error) {
    return res.status(500).json({ message: error });
  }
};

export const logoutUser = async (req, res) => {
  res.clearCookie("userToken");
  
  return res.json({ message: "Sessão terminada com sucesso!", success: true });
  //return res.status(200).json({ message: "Sessão terminada com sucesso!", success: true });
};


export const searchUsers = async (req, res) => {
  try {
    const { q } = req.query;

    if (!q) {
      return res.status(400).json({ message: "O parâmetro de pesquisa \"q\" é necessário" });
    }
    
    const users = await prisma.user.findMany({
      where: {
        OR: [
          { full_name: { equals: q }, },
          { username: { equals: q }, },
          { email: { equals: q }, },
          { organization_name: { equals: q }, },
          { organization_type: { equals: q }, },
          { organization_contact_info: { equals: q }, },
          { contact_phone: { equals: q }, },
          { contact_address: { equals: q }, },
        ]
      }
    });

    if (!users || users.length==0) return res.status(404).send({ message: "Nenhum usuário encontrado com esse parâmetro" });

    res.json(users);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

