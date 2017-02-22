package pkgfinal;

import javafx.application.Application;

import javafx.fxml.FXMLLoader;

import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * Final class is a program is intended to simulate a SSL encrypted 
 * sign-in to eventually grant employee access to door. The first scene 
 * (window) is the user log-in page. The second scene is the user info
 * page that includes a special QR code just for that employee.
 * 
 * @author Kimberly D. Gordon-Bercich (S01457336)
 * @version 6, 2016-12-08, CSC-241 Assignment Final, SSL simulation.
 */
public class Final extends Application 
{
    /*Creating a stage for all scenes to be add onto.*/
    Stage myStage;
        
    @Override
    public void start(Stage stage) throws Exception 
    {
        /*Make stage available in other methods.*/
        myStage = stage;
        
        /*Set root to find the Final.fxml file which opens first scene.*/
        Parent root = FXMLLoader.load(getClass().getResource("Final.fxml"));
        
        /*Name the scene and assign it to root.*/
        Scene finalScene = new Scene(root);
        
        /*Create the stage*/
        myStage.setTitle("User Login");
        myStage.setScene(finalScene);
        myStage.show();
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    
}
