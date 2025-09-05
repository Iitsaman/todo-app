import { connect } from "mongoose"

const connectionDB = async () =>{

  try{
    const mongoURI = process.env.MONGO_URI;
    
     await connect(mongoURI)
    console.log("mogodb conected")
  
  } catch(error){
    console.error("fail",error)

}
}

export default connectionDB