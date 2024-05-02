import prisma from "../config/PrismaClient.js";
import jwt from "jsonwebtoken";
import { secretKey } from "../config/generateSecretKey.js";

export const isAuthenticated = async (req, res, next) => {
  try {
    const { userToken } = req.cookies;

    if (!userToken) {
      // No user token present, return 401 Unauthorized
      return res.status(401).json({ message: "Sem autorização" });
    }

    // Decode token to get payload without verifying the signature
    const decodedTokenWithoutVerification = jwt.decode(userToken, { complete: true });
    const now = Math.floor(Date.now() / 1000); // Current time in seconds

    // Check if token has expired or not
    if (decodedTokenWithoutVerification.payload.exp <= now) {
        return res.status(401).json({ message: 'Sem autorização. A sessão expirou!' }); //Token has expired
    }

    const verifiedToken = jwt.verify(userToken, secretKey);

    const user = await prisma.user.findUnique({
      where: { email: verifiedToken.email },
    });

    if (!user) {
      // User not found in database, return 401 Unauthorized
      return res.status(401).json({ message: "Sem autorização" });
    }

    req.user = user;
    next();
  } catch (error) {
    return res.status(500).json({ message: "Internal server error", data: error});
  }
};