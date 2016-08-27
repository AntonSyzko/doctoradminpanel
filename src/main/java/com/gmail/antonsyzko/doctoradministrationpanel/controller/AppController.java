package com.gmail.antonsyzko.doctoradministrationpanel.controller;

import com.gmail.antonsyzko.doctoradministrationpanel.model.User;
import com.gmail.antonsyzko.doctoradministrationpanel.model.UserProfile;
import com.gmail.antonsyzko.doctoradministrationpanel.service.UserDocumentService;
import com.gmail.antonsyzko.doctoradministrationpanel.service.UserProfileService;
import com.gmail.antonsyzko.doctoradministrationpanel.service.UserService;
import com.gmail.antonsyzko.doctoradministrationpanel.utils.EmailUtil;
import com.gmail.antonsyzko.doctoradministrationpanel.utils.FileValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.awt.*;
import java.util.List;
import java.util.Locale;
import java.util.Properties;


@Controller
@RequestMapping("/")
@SessionAttributes("roles")
public class AppController {






	@Autowired
	UserService userService;



	
	@Autowired
	UserProfileService userProfileService;
	
	@Autowired
	MessageSource messageSource;



	@Autowired
	PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;
	
	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;
	
	
	/**
	 * This method will list all existing users.
	 */
	@RequestMapping(value = { "/", "/list" }, method = RequestMethod.GET)
	public String listUsers(ModelMap model) {

		List<User> users = userService.findAllUsers();
		model.addAttribute("users", users);
		model.addAttribute("loggedinuser", getPrincipal());
























		//added sound
		final Runnable runnable = (Runnable) Toolkit.getDefaultToolkit().getDesktopProperty("win.sound.exclamation");




























		if (runnable != null) runnable.run();
		return "userslist";
	}




	/**
	 * This method will provide the medium to add a new user.
	 */
	@RequestMapping(value = { "/newuser" }, method = RequestMethod.GET)
	public String newUser(ModelMap model) {
		User user = new User();
		model.addAttribute("user", user);
		model.addAttribute("edit", false);
		model.addAttribute("loggedinuser", getPrincipal());





		return "registration";
	}




	/**
	 * This method will be called on form submission, handling POST request for
	 * saving user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/newuser" }, method = RequestMethod.POST)
	public String saveUser(@Valid User user, BindingResult result,
			ModelMap model) {

		if (result.hasErrors()) {
			return "registration";
		}

		/*
		 * Preferred way to achieve uniqueness of field [sso] should be implementing custom @Unique annotation 
		 * and applying it on field [sso] of Model class [User].
		 * 
		 * Below mentioned peace of code [if block] is to demonstrate that you can fill custom errors outside the validation
		 * framework as well while still using internationalized messages.
		 * 
		 */
		if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
			FieldError ssoError =new FieldError("user","ssoId",messageSource.getMessage("non.unique.ssoId", new String[]{user.getSsoId()}, Locale.getDefault()));
		    result.addError(ssoError);
			return "registration";
		}


             sendEmail(user);


		userService.saveUser(user);

		model.addAttribute("success", "User  " + user.getFirstName() + "  "+ user.getLastName() + " You have successfully registered.");
		model.addAttribute("email_confirmation"," Confirmation email has  been sent to :");
		model.addAttribute("very_email",user.getEmail());
		model.addAttribute("close_mail"," Please, check Your email. ");
		model.addAttribute("loggedinuser", getPrincipal());
		//return "success";
		return "registrationsuccess";
	}


	/*
	uses EmailUtil
	three options - simple mail, mail with attach, mail with image
	 */
     public void sendEmail(User user){
		 //sending email to new  verified and recently saved  user
		 final String fromEmail = "antonsyzko@gmail.com"; //requires valid gmail id
		 final String password = "uspehsomnoi"; // correct password for gmail id
		 System.out.println("SSLEmail Start");
		 Properties props = new Properties();
		 props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
		 props.put("mail.smtp.socketFactory.port", "465"); //SSL Port
		 props.put("mail.smtp.socketFactory.class",
				 "javax.net.ssl.SSLSocketFactory"); //SSL Factory Class
		 props.put("mail.smtp.auth", "true"); //Enabling SMTP Authentication
		 props.put("mail.smtp.port", "465"); //SMTP Port

		 Authenticator auth = new Authenticator() {
			 //override the getPasswordAuthentication method
			 protected PasswordAuthentication getPasswordAuthentication() {
				 return new PasswordAuthentication(fromEmail, password);
			 }
		 };
		 Session session = Session.getDefaultInstance(props, auth);
		 System.out.println("Session created");
		 EmailUtil.sendImageEmail(session, user.getEmail(), "Welcome to Private Doctor Administration  Panel",
				 "  Welcome to  Private Doctor Administration  Panel, You have succesfully registered . Your  credentials are :\r\n" +
						 "  Name :   "+user.getFirstName() + "\r\n  Surname :   " + user.getLastName()+ "\r\n  registration email :   "+ user.getEmail() + "\r\n  phone  "+user.getPhone()+
						 "\r\n  LOGIN (to be  used enter the Adminstration Page ) :   " +  user.getSsoId() +"\r\n  PASSWORD  ( to be  used to enter the Administration page ) :   " +
						 user.getPassword() + " \r\n  Thank Your for  joining , we will take care  of Your health ! \r\n  call us +(351) 916 111 042 \r\n  or visit us "+
						 "    Rua Capitaes  de Abril 13 - 4 ESQ \r\n  Alfornelos Lisbon\r\n  2650 - 352 \r\n  Portugal ")  ;


	 }
	/**
	 * This method will provide the medium to update an existing user.
	 */
	@RequestMapping(value = { "/edit-user-{ssoId}" }, method = RequestMethod.GET)
	public String editUser(@PathVariable String ssoId, ModelMap model) {
		User user = userService.findBySSO(ssoId);
		model.addAttribute("user", user);
		model.addAttribute("edit", true);
		model.addAttribute("loggedinuser", getPrincipal());
		return "registration";
	}





	/**
	 * This method will be called on form submission, handling POST request for
	 * updating user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/edit-user-{ssoId}" }, method = RequestMethod.POST)
	public String updateUser(@Valid User user, BindingResult result,
			ModelMap model, @PathVariable String ssoId) {

		if (result.hasErrors()) {
			return "registration";
		}

		/*//Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in UI which is a unique key to a User.
		if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
			FieldError ssoError =new FieldError("user","ssoId",messageSource.getMessage("non.unique.ssoId", new String[]{user.getSsoId()}, Locale.getDefault()));
		    result.addError(ssoError);
			return "registration";
		}*/


		userService.updateUser(user);

		model.addAttribute("success", "User " + user.getFirstName() + " "+ user.getLastName() + " updated successfully");
		model.addAttribute("loggedinuser", getPrincipal());
		return "registrationsuccess";
	}




	
	/**
	 * This method will delete an user by it's SSOID value.
	 */
	@RequestMapping(value = { "/delete-user-{ssoId}" }, method = RequestMethod.GET)
	public String deleteUser(@PathVariable String ssoId) {
		userService.deleteUserBySSO(ssoId);
		return "redirect:/list";
	}



	/**
	 * This method will provide UserProfile list to views
	 */
	@ModelAttribute("roles")
	public List<UserProfile> initializeProfiles() {
		return userProfileService.findAll();
	}
	
	/**
	 * This method handles Access-Denied redirect.
	 */
	@RequestMapping(value = "/Access_Denied", method = RequestMethod.GET)
	public String accessDeniedPage(ModelMap model) {
		model.addAttribute("loggedinuser", getPrincipal());
		return "accessDenied";
	}

	/**
	 * This method handles login GET requests.
	 * If users is already logged-in and tries to goto login page again, will be redirected to list page.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPage() {
		if (isCurrentAuthenticationAnonymous()) {


			return "login";
	    } else {
	    	return "redirect:/list";
	    }
	}

	/**
	 * This method handles logout requests.
	 * Toggle the handlers if you are RememberMe functionality is useless in your app.
	 */
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutPage (HttpServletRequest request, HttpServletResponse response){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){    
			//new SecurityContextLogoutHandler().logout(request, response, auth);
			persistentTokenBasedRememberMeServices.logout(request, response, auth);
			SecurityContextHolder.getContext().setAuthentication(null);
		}
		return "redirect:/login?logout";
	}

	/**
	 * This method returns the principal[user-name] of logged-in user.
	 */
	private String getPrincipal(){
		String userName = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
			userName = ((UserDetails)principal).getUsername();
		} else {
			userName = principal.toString();
		}
		return userName;
	}
	
	/**
	 * This method returns true if users is already authenticated [logged-in], else false.
	 */
	private boolean isCurrentAuthenticationAnonymous() {
	    final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    return authenticationTrustResolver.isAnonymous(authentication);
	}












































	@Autowired
	UserDocumentService userDocumentService;



	@Autowired
	FileValidator fileValidator;

	@InitBinder("fileBucket")
	protected void initBinder(WebDataBinder binder) {
		binder.setValidator(fileValidator);
	}

	/**
	 * This method will list all existing users.
	 */














//
//	@RequestMapping(value = { "/add-document-{userId}" }, method = RequestMethod.GET)
//	public String addDocuments(@PathVariable int userId, ModelMap model) {
//		User user = userService.findById(userId);
//		model.addAttribute("user", user);
//
//		FileBucket fileModel = new FileBucket();
//		model.addAttribute("fileBucket", fileModel);
//
//		List<UserDocument> documents = userDocumentService.findAllByUserId(userId);
//		model.addAttribute("documents", documents);
//
//		return "managedocuments";
//	}
//
//
//	@RequestMapping(value = { "/download-document-{userId}-{docId}" }, method = RequestMethod.GET)
//	public String downloadDocument(@PathVariable int userId, @PathVariable int docId, HttpServletResponse response) throws IOException {
//		UserDocument document = userDocumentService.findById(docId);
//		response.setContentType(document.getType());
//		response.setContentLength(document.getContent().length);
//		response.setHeader("Content-Disposition","attachment; filename=\"" + document.getName() +"\"");
//
//		FileCopyUtils.copy(document.getContent(), response.getOutputStream());
//
//		return "redirect:/add-document-"+userId;
//	}
//
//	@RequestMapping(value = { "/delete-document-{userId}-{docId}" }, method = RequestMethod.GET)
//	public String deleteDocument(@PathVariable int userId, @PathVariable int docId) {
//		userDocumentService.deleteById(docId);
//		return "redirect:/add-document-"+userId;
//	}
//
//	@RequestMapping(value = { "/add-document-{userId}" }, method = RequestMethod.POST)
//	public String uploadDocument(@Valid FileBucket fileBucket, BindingResult result, ModelMap model, @PathVariable int userId) throws IOException{
//
//		if (result.hasErrors()) {
//			System.out.println("validation errors");
//			User user = userService.findById(userId);
//			model.addAttribute("user", user);
//
//			List<UserDocument> documents = userDocumentService.findAllByUserId(userId);
//			model.addAttribute("documents", documents);
//
//			return "managedocuments";
//		} else {
//
//			System.out.println("Fetching file");
//
//			User user = userService.findById(userId);
//			model.addAttribute("user", user);
//
//			saveDocument(fileBucket, user);
//
//			return "redirect:/add-document-"+userId;
//		}
//	}
//
//	private void saveDocument(FileBucket fileBucket, User user) throws IOException{
//
//		UserDocument document = new UserDocument();
//
//		MultipartFile multipartFile = fileBucket.getFile();
//
//		document.setName(multipartFile.getOriginalFilename());
//		document.setDescription(fileBucket.getDescription());
//		document.setType(multipartFile.getContentType());
//		document.setContent(multipartFile.getBytes());
//		document.setUser(user);
//		userDocumentService.saveDocument(document);
//	}


}