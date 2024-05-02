import prisma from "../config/PrismaClient.js";
import * as location from "./LocationController.js";
import * as comment from "./CommentsController.js";
import multer from 'multer';

// Set up multer storage for file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/images/');
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, file.fieldname + '-' + uniqueSuffix + '-' + file.originalname);
  }
});

const upload = multer({ storage: storage }).single('image');

export const getMissingPersons = async (req, res) => {
  try {

    const missingpersons = await prisma.missingperson.findMany({
   
        include: {
          user: {
            select: {
              full_name: true
                }
              },
          location: {
            include: {
              district: {
                select: {
                  district_name: true
                }
              }
            }
          }   
            }
      });

    if (!missingpersons) return res.status(404).send({ message: "Nenhuma pessoa desaparecida encontrada"});
    
    res.status(200).json({ missingpersons: missingpersons });
    
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const getMissingPersonById = async (req, res) => {
  try {
        
        const missing_person_id = parseInt(req.params.id);

        const missing_person = await prisma.missingperson.findUnique({ 
          where: { missing_person_id },
          include: { 
            comment: { 
              include: { 
                user: { select: { full_name: true } } 
              } 
            },
            location: {
              include: {
                district: {
                  include: {
                    province: { select: { province_name: true } }
                  }
                }
              }
            },
            user: { select: { full_name: true } }
          }
        });
        
        if (!missing_person) return res.status(404).send({ message: "Nenhuma pessoa desaparecida encontrada" });
        
        res.json({missingperson: missing_person});
      
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
  
    export const reportMissingPerson = async (req, res) => {
      try {
        upload(req, res, async function (err) {
          if (err instanceof multer.MulterError) {
            // A Multer error occurred when uploading.
            return res.status(500).json({ message: err.message });
          } else if (err) {
            // An unknown error occurred when uploading.
            return res.status(500).json({ message: err.message });
          }
    
          // No file uploaded, proceed with other data
          const { name, age, gender, missing_person_description, contact_info, district_id, location_description } = req.body;
    
          // Extract file name from request
          const image = req.file ? req.file.filename : null;
    
          // Validate required fields
          if (!name || !gender || !missing_person_description) {
            return res.status(400).json({ message: "Preencha todos os campos obrigatórios" });
          }
    
          // Create location based on the district and description provided
          const last_known_location_id = await location.createLocation(parseInt(district_id), location_description);
    
          const { user_id } = req.user;
    
          const data = {
            name,
            age,
            gender,
            description: missing_person_description,
            contact_info,
            last_known_location_id,
            reported_by_id: user_id,
            image
          };
    
          // Include optional fields in the data object if provided in the request body
          const optionalFields = ['age', 'contact_info'];
          
          for (const field of optionalFields) {
            if (req.body[field] !== undefined) {
              if(field =='age') {
                data[field] = parseInt(req.body[field])
                  } 
                else{
                  data[field] = req.body[field]
                }
              }
            }
              
          // Create missing person entry in the database
          const missingPerson = await reportPerson(data);
    
          if (!missingPerson) {
            return res.status(500).json({ message: "Erro, o registo de pessoa desaparecida não foi criado", success: false});
          }
    
          return res.status(200).json({ message: "Pessoa desaparecida participada com sucesso", success: true, data: missingPerson });
        });
      } catch (error) {
        console.error('Erro ao participar pessoa desaparecida:', error);
        return res.status(500).json({ message: "Erro ao participar pessoa desaparecida", data: error });
      }
    };


    export const reportPerson = async (data) => {
      try {
              return await prisma.missingperson.create({data});
        } catch (error) {          
          console.error('Erro ao criar o registo de pessoa desaparecida na base de dados:', error);
          throw error;
        }
    };
      
export const updateMissingPerson = async (req, res) => {

// Define an array of sensitive fields that should not be updated
  const sensitiveFields = ['missing_person_id', 'name', 'reported_by_id', 'reported_at', 'comment'];

  try {
    const missing_person_id = parseInt(req.params.id);
    let missingPersonData = req.body;
    const { user_id } = req.user;
    //const posted_by_id_2 = 1;

    // Check if at least one non-sensitive field is provided for update
    if (Object.keys(missingPersonData).length === 0) {
      return res.status(400).json({ message: "Deve ser fornecido pelo menos um campo para atualização. Note que os campos sensíveis (p.ex: nome da pessoa desaparecida), não poderão ser alterados."});
    }
    
    // Check if a comment was provided then post a new comment
    if (missingPersonData['comment']) await comment.createComment(missing_person_id, missingPersonData['comment'], user_id);
    
    // Exclude sensitive fields from the missingPersonData object
      missingPersonData = Object.fromEntries(
      Object.entries(missingPersonData).filter(([key]) => !sensitiveFields.includes(key))
    );
    
    const updatedmissingPerson = await prisma.missingperson.update({
      where: {missing_person_id},
      data: missingPersonData, 
    });

    res.status(200).json({message: "Registo de pessoa desaparecida atualizado com sucesso", success: true, data: updatedmissingPerson});

  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const searchMissingPersons = async (req, res) => {
  try {
    const { q } = req.query;

    if (!q) {
      return res.status(400).json({ message: "O parâmetro de pesquisa \"q\" é necessário" });
    }
    
    const missing_person = await prisma.missingperson.findMany({
      where: {
        OR: [
          { name: { equals: q }, },
          { description: { equals: q }, },
          { contact_info: { equals: q }, },
        ]
      }
    });

    if (!missing_person || missing_person.length==0) return res.status(404).send({ message: "Nenhuma pessoa desaparecida encontrada com esse parâmetro" });

    res.json(missing_person);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};