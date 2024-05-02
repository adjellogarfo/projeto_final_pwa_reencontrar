import express from "express";
import cookieParser from "cookie-parser";
import cors from "cors";
import dotenv from "dotenv";
import router from "./routes/index.js";


dotenv.config();
const app = express();

app.use('/uploads', express.static('uploads'));

const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(cookieParser());
app.use(
  cors({
    credentials: true,
    origin: process.env.CLIENT_PORT || 8000,
  })
);
app.use(router);

app.listen(PORT, () => {
  console.log(`Server Running @ PORT ${PORT}...`);
});
