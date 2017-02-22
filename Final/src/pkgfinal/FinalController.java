/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pkgfinal;

import java.io.File;
import java.io.IOException;

import java.net.URL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ResourceBundle;

import javafx.event.ActionEvent;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;

import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

import javafx.stage.Stage;

/**
 * @author Kimberly D. Gordon-Bercich (S01457336)
 * @version 6, 2016-12-08, CSC-241 Assignment Final, SSL simulation.
 */
public class FinalController implements Initializable 
{
    /**
     * The password for access to the database.
     */
    private static final String PASSWORD = "password";

    /**
     * Database URL.
     */
    private static final String URL = "jdbc:mysql://localhost:3306/capstone_kgordonbercich" +
                                                                                    "?autoReconnect=true&useSSL=false";

    /**
     * The username for access to the database.
     */
    private static final String USERNAME = "root";
    
    /**
     * Set logo as visible with ImageView.
     */
    @FXML
    private ImageView imageView;

    /**
     * Database connection (after it has been established).
     */
    private Connection connection;
    
    /**
     * Set variable for Current Employee ID to move through the table
     */
    int currentUserID;
    
    /* userIDTextField control defined in FXML and used by the 
       controller's code. */
    @FXML
    private TextField userIDTextField;
    
    /* passwordTextField control defined in FXML and used by the 
       controller's code. */
    @FXML
    private TextField passwordField;
    
    /* employeID control defined in FXML and used by the controller's
       controller's code. */
    @FXML
    private Label employeeID;
    
    /* employeeName control defined in FXML and used by the controller's
       controller's code. */
    @FXML
    private Label employeeName;
    
    /* signInButton control defined in FXML and used by the controller's
        controller's code. */
    @FXML
    private Button signInButton;
    
    
    /* Handles action event for signInButton control defined in FXML and 
       used by the controller's code. */
    @FXML
    private void signInButtonAction(ActionEvent event) 
    {      
        /* Capture employeeIDNumber by running validateCredentials method. */
        String employeeIDNumber = validateCredentials();
        
        /* if employeeIDNumber gets returned open UserAccess window. */
        if(employeeIDNumber != null)
        {
            /*Close the sign-in window.*/
            Stage stage = (Stage) signInButton.getScene().getWindow();
            stage.close();

            try
            {
                              
                /* userAccessLoader get access to UserAccess.fxml */
                FXMLLoader userAccessLoader = 
                        new FXMLLoader(getClass().getResource("UserAccess.fxml"));

                /* userAccessRoot is assigned to load userAccessLoader scene. */
                Parent userAccessRoot = userAccessLoader.load();

                /* userAccessController get the controller and allow 
                    userAccessLoader to call on its functions and 
                    controlls. */
                UserAccessController userAccessController = userAccessLoader.getController();

                /* Calls the function openEEInfo and feeds in the 
                    employeeIDNumber so the correct employee information
                    pulls up on the UserAccess window. */
                userAccessController.openEEInfo(employeeIDNumber);
                
                /* userAccessStage sets new stage to open new 
                    scene (window) to allow user to view user information. */
                Stage userAccessStage = new Stage();
                
                /* userAccessScene build the window the user will view
                    and sets size of window. */
                Scene userAccessScene = new Scene(userAccessRoot, 700, 600);
                
                /* Set the title of the window, choose UserAccessScene
                    as the window to open, and make the widow visible to 
                    the user. */
                userAccessStage.setTitle("User Access");
                userAccessStage.setScene(userAccessScene);
                userAccessStage.show();
                
            }
            catch (IOException e)
            {
                System.out.println(e.getMessage()); 
            }
        }//end if
        
        /* Final close connection to database.*/
        try
        {
            connection.close();
        }
        catch (SQLException e) 
        {
                System.out.println(e.getMessage()); 
        }
        
    } //end signInButton
       
    public String validateCredentials ()
    {
        /* userID gets the user ID from the user input on the
            sign-in window. */
        String userID = userIDTextField.getText();
        
        /* password gets the user password from teh user input on the sign-in
            window and will be compared to the encrypted password in the 
            database. */
        String password = passwordField.getText();
        
        /* encryptionKey simulates the SSL. It is stored in a seperate 
            table in the databse as a blob using AES_ENCRYPTION.
         */
        java.sql.Blob encryptionKey;
        
        /* encryptedPassword simulates access the SSL. It is stored 
            in the database as a blob using AES_ENCRYPTION.
         */
        java.sql.Blob encryptedPassword;
        
        /* encryptionKeySting allows the encryptionKey to be compared. */
        String encryptionKeyString;
        
        /* employeeIDNumber is stored from database for later use.*/
        String employeeIDNumber = null;
        
        /* validatingEmployeeRS returns the query to pull user info from 
            database. */
        ResultSet validatingEmployeeRS;
        
        /* getData confirms valid data is returned. */
        boolean getData = false;
        
        /* Now we are going to connect to database and try to confirm
            username and password are vaild. */
        try
        {
            /* connection actually connects to the database. */
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
            /* encryptionKeyQuery gets the data from the encryptionKey table
                where the password and userID is stored. */
            String encryptionKeyQuery = "SELECT * FROM encryptionkey WHERE idencryptionKey = 1";
            
                try
                ( 
                    /* encryptionKeyPST creates a PreparedStatement to funnel the
                        query through. */ 
                    PreparedStatement encryptionKeyPST = connection.prepareStatement(encryptionKeyQuery)) 
                    {
                        /* encryptionKeyRS runs the query and returns the results.*/
                        ResultSet encryptionKeyRS = encryptionKeyPST.executeQuery();
                        if (encryptionKeyRS.next())
                        {
                            encryptionKey = encryptionKeyRS.getBlob("encryptionKey");
                            byte[] bdata = encryptionKey.getBytes(1, (int) encryptionKey.length());
                            encryptionKeyString = new String(bdata);

                            getData = true;
                        }
                        else
                        {
                            encryptionKey = null;
                            encryptionKeyString = null;

                            /*Debugging*/
                            System.out.println("Encryption Failed.");
                        }
                        /* Once the data is returned we can validate that the
                        encrypted password and encryption key are valid with
                        what the user input. */
                        try 
                        {
                            /* query calls the information from the table. */
                            String query = "SELECT * FROM useridandpassword WHERE UserID='" +
                                    userID + "' AND CAST(AES_ENCRYPT('" + password + "', '" + 
                                    encryptionKeyString + "') AS BINARY(128)) = PasswordWord";

                            try ( 
                                    /* pst creates a PreparedStatement to 
                                        funnel the query through. */ 
                                    PreparedStatement pst = connection.prepareStatement(query)) 
                                    {
                                        /* validatingEmployeeRS runs the query and returns
                                        the results.*/
                                        validatingEmployeeRS = pst.executeQuery();
                                        /* capture employeeIDNumber for later use. */
                                        if (validatingEmployeeRS.next()) {
                                            employeeIDNumber =
                                                    validatingEmployeeRS.getString("EmployeeID");

                                            getData = true;
                                        } else {
                                            employeeIDNumber = null;
                                        }
                                        
                                    }
                        }catch (SQLException e) 
                        {
                            System.out.println(e.getMessage()); 
                        }

                    }
                /* Close prepared statement encryptionKeyPST and close
                    connection to database.*/
                connection.close();
            }
        catch (SQLException e) 
	{
		System.out.println(e.getMessage()); 
	}
        
        return employeeIDNumber;
    }
    
    /**
     * intialize method allows logo to be viewed on sign-in window.
     * 
     * @param url
     * @param rb 
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) 
    {
        File file = new File("src/resources/PICTURE_Knowledge.jpg");
        Image image = new Image(file.toURI().toString());
        imageView.setImage(image);
    }    
    
}