/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pkgfinal;

import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;

import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

import java.io.File;
import java.io.IOException;

import java.util.EnumMap;
import java.util.Map;
 
import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

/**
 *
 * @author Kimberly D. Gordon-Bercich (S01457336)
 * @author crunchify retrieved from http://crunchify.com/java-simple-qr-code-generator-example/
 * @version 6, 2016-12-08, CSC-241 Assignment Final, SSL simulation.
 */
public class UserAccessController implements Initializable 
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
     * Database connection (after it has been established).
     */
    private Connection connection;
    
    /**/
    private String eeImage;
    
    /**
     * Set ee picture as visible with ImageView.
     */
    @FXML
    private ImageView eeImageView;
    
    /**
     * Set QR picture as visible with ImageView.
     */
    @FXML
    private ImageView qrImageView;
    
    /**
     * employeID control defined in FXML and used by the controller's
     * code. 
     */
    @FXML
    private TextField employeeIDTextField;
    
    /** 
     * employeeName control defined in FXML and used by the controller's 
     * code. 
     */
    @FXML
    private TextField employeeNameTextField;
    
    /**
     * employeeTitle control defined in FXML and used by the controller's
     * code.
     */
    @FXML
    private TextField employeeTitleTextField;
    
    /**
     * employeeRegionTextFiled control defined in FXML and used by the
     * controller's code.
     */
    @FXML
    private TextField employeeRegionTextField;
    
    /**
     * openEEInfo gets employee data from the table employees and displays
     * the information on the User Access window.
     * 
     * @param employeeIDNumber
     * @throws IOException 
     */
    
    public void openEEInfo (String employeeIDNumber) throws IOException 
    {
        try
        {
            /* connection actually connects to the database. */
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        
            /* getData confirms valid data is returned. */
            boolean getData = false;

            /* getEEQuery gets the data from the emploees table
                where the employee data is stored. */
            String getEEQuery = 
                    "SELECT * FROM employees WHERE EmployeeID= '" + 
                    employeeIDNumber + "'";

            /* eeInforPST creates a PreparedStatement to funnel the 
                query through. */
            PreparedStatement eeInfoPST = 
                    connection.prepareStatement(getEEQuery);

            /* eeInfoRS runs the query and returns the results.*/
            ResultSet eeInfoRS = eeInfoPST.executeQuery();
            
            if(eeInfoRS.next())
            {
                /* employeeID captures the employeeID from the 
                    EmployeeID column in the database. */
                String employeeID = (eeInfoRS.getString("EmployeeID"));
                
                /* firstName captures the EE first name from the 
                    EmployeeFirstName column in the database. */
                String firstName = (eeInfoRS.getString("EmployeeFirstName"));

                /* lastName captures the EE last name from the 
                    EmployeeLastName column in the database. */
                String lastName = (eeInfoRS.getString("EmployeeLastName"));
                
                /* employeeName concatinates the first and last name together. */
                String employeeName = firstName + " " + lastName;
                
                /* employeeTitle captures the EE title from the 
                    EmployeeTitle column in the database. */
                String employeeTitle = (eeInfoRS.getString("EmployeeTitle"));
                
                /* employeeRegion captures the EE region from the 
                    Region column in the database. */
                String employeeRegion = (eeInfoRS.getString("Region"));
                
                /* eeImage allows java to find the file where the 
                    employee image is stored and the file path is 
                    found in the eeImage colum of the database. */
               eeImage = (eeInfoRS.getString("eeImage")); 
                
                /* Sets the employeeIDTextField to the employeeID
                   found in the database. */
                employeeIDTextField.setText(employeeID);
                
                /* Sets the employeeNameTextField to the employee name
                   found in the database. */
                employeeNameTextField.setText(firstName + " " + lastName);
                
                /* Sets the employeeNameTextField to the employee name
                   found in the database. */
                employeeTitleTextField.setText(employeeTitle);
                
                /* Sets the employeeRegionTextField to the employee region
                   found in the database. */
                employeeRegionTextField.setText(employeeRegion);
                
                /* Finds the file and allows the employee image to show. */
                File file = new File(eeImage);
                Image image = new Image(file.toURI().toString());
                eeImageView.setImage(image);
                
                /* Call createQRCode method to create a custom QR code
                    based off the employeeName. */
                createQRCode(employeeName);
                
                /* Finds the file and allows the QR image to show. */
                File qrFile = new File("src/resources/QRCodePic.png");
                Image qrImage = new Image(qrFile.toURI().toString());
                qrImageView.setImage(qrImage);

                getData = true;

            }
            else
            {
               Alert alertWarning = new Alert(AlertType.ERROR);
               alertWarning.setTitle("Employee Not Found");
               alertWarning.setContentText("Consult your database administrator.");

               alertWarning.showAndWait();
            }    
        }
        catch (SQLException e) 
        {
                System.out.println(e.getMessage()); 
        }
    }
    
    @Override
    public void initialize(URL url, ResourceBundle resource) 
    {        
        //To Do
    }  
    
    /**
     * Creates a QR code to be used to grant EE access to doors/buildings.
     * 
     * @author crunchify
     * @param employeeName
     * @throws IOException 
     */
    public void createQRCode(String employeeName) throws IOException
    {
        String myCodeText = employeeName;
		String filePath = "src/resources/QRCodePic.png";
		int size = 250;
		String fileType = "png";
		File myFile = new File(filePath);
		try {
			
			Map<EncodeHintType, Object> hintMap = new EnumMap<>(EncodeHintType.class);
			hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
			
			// Now with zxing version 3.2.1 you could change border size (white border size to just 1)
			hintMap.put(EncodeHintType.MARGIN, 1); /* default = 4 */
			hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
 
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix byteMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size,
					size, hintMap);
			int CrunchifyWidth = byteMatrix.getWidth();
			BufferedImage image = new BufferedImage(CrunchifyWidth, CrunchifyWidth,
					BufferedImage.TYPE_INT_RGB);
			image.createGraphics();
 
			Graphics2D graphics = (Graphics2D) image.getGraphics();
			graphics.setColor(Color.WHITE);
			graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
			graphics.setColor(Color.BLACK);
 
			for (int i = 0; i < CrunchifyWidth; i++) {
				for (int j = 0; j < CrunchifyWidth; j++) {
					if (byteMatrix.get(i, j)) {
						graphics.fillRect(i, j, 1, 1);
					}
				}
			}
			ImageIO.write(image, fileType, myFile);
		} catch (WriterException e) {
			System.out.println(e.getMessage()); 
		}
		System.out.println("\n\nYou have successfully created QR Code.");
        
    }
    
}
