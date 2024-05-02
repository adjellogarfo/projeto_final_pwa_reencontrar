import prisma from "../config/PrismaClient.js";

export const createLocationByDistrict = async (district_id) => {
  try {
        
        const location = await prisma.location.create({
          data: { district_id},
        });
        
        return location.location_id;
      
  } catch (error) {
    console.error('Error creating location:', error);
    throw error;
  }
};

export const createLocation = async (district_id, description) => {
  try {
        
        const location = await prisma.location.create({
          data: { district_id, description},
        });
        
        return location.location_id;
      
      } catch (error) {
        console.error('Error creating location:', error);
        throw error;
      }
};
