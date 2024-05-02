import express from "express";
import * as user from "../controllers/UserController.js";
import * as missingPerson from "../controllers/MissingPersonController.js";
import { isAuthenticated } from "../middlewares/Auth.js";

const router = express.Router();
// User Routes

router.post("/users", user.registerUser); //done
router.get("/users/:id", isAuthenticated, user.getUserById); //done
router.get("/users", isAuthenticated, user.getUsers); //done
router.put("/users/:id", isAuthenticated, user.updateUser); //done
router.delete("/users/:id", isAuthenticated, user.deleteUser); //done
router.post("/user/login", user.loginUser); //done
router.post("/user/logout", isAuthenticated, user.logoutUser); //done

// Missing Persons Routes
router.post("/missing-persons", isAuthenticated, missingPerson.reportMissingPerson); //done
router.get("/missing-persons/:id", missingPerson.getMissingPersonById); //done
router.get("/missing-persons", missingPerson.getMissingPersons); //done
router.put("/missing-persons/:id", isAuthenticated, missingPerson.updateMissingPerson); //done

// Search Routes
router.get("/search/users", isAuthenticated, user.searchUsers); //partial done
router.get("/search/missing-persons", missingPerson.searchMissingPersons); //partial done

export default router;
