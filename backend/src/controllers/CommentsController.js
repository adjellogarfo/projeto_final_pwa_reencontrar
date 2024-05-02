import prisma from "../config/PrismaClient.js";

export const createComment = async (missing_person_id, comment_text, posted_by_id) => {
  try {
        
        const comment = await prisma.comment.create({
          data: { missing_person_id, comment: comment_text, posted_by_id},
        });
        
        return comment.comment_id;
      
      } catch (error) {
        console.error('Error creating comment:', error);
        throw error;
      }
};
