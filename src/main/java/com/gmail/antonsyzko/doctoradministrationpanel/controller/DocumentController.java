package com.gmail.antonsyzko.doctoradministrationpanel.controller;

/**
 * Created by Admin on 18.08.2016.
 */

import com.gmail.antonsyzko.doctoradministrationpanel.model.FileBucket;
import com.gmail.antonsyzko.doctoradministrationpanel.model.User;
import com.gmail.antonsyzko.doctoradministrationpanel.model.UserDocument;
import com.gmail.antonsyzko.doctoradministrationpanel.service.UserDocumentService;
import com.gmail.antonsyzko.doctoradministrationpanel.service.UserProfileService;
import com.gmail.antonsyzko.doctoradministrationpanel.service.UserService;
import com.gmail.antonsyzko.doctoradministrationpanel.utils.FileValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.List;


@Controller
@RequestMapping("/")
@SessionAttributes("roles")
public class DocumentController {

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



    @RequestMapping(value = { "/add-document-{userId}" }, method = RequestMethod.GET)
    public String addDocuments(@PathVariable int userId, ModelMap model) {
        User user = userService.findById(userId);
        model.addAttribute("user", user);

        FileBucket fileModel = new FileBucket();
        model.addAttribute("fileBucket", fileModel);

        List<UserDocument> documents = userDocumentService.findAllByUserId(userId);
        model.addAttribute("documents", documents);

        return "managedocuments";
    }


    @RequestMapping(value = { "/download-document-{userId}-{docId}" }, method = RequestMethod.GET)
    public String downloadDocument(@PathVariable int userId, @PathVariable int docId, HttpServletResponse response) throws IOException {
        UserDocument document = userDocumentService.findById(docId);
        response.setContentType(document.getType());
        response.setContentLength(document.getContent().length);
        response.setHeader("Content-Disposition","attachment; filename=\"" + document.getName() +"\"");

        FileCopyUtils.copy(document.getContent(), response.getOutputStream());

        return "redirect:/add-document-"+userId;
    }

    @RequestMapping(value = { "/delete-document-{userId}-{docId}" }, method = RequestMethod.GET)
    public String deleteDocument(@PathVariable int userId, @PathVariable int docId) {
        userDocumentService.deleteById(docId);
        return "redirect:/add-document-"+userId;
    }

    @RequestMapping(value = { "/add-document-{userId}" }, method = RequestMethod.POST)
    public String uploadDocument(@Valid FileBucket fileBucket, BindingResult result, ModelMap model, @PathVariable int userId) throws IOException{

        if (result.hasErrors()) {
            System.out.println("validation errors");
            User user = userService.findById(userId);
            model.addAttribute("user", user);

            List<UserDocument> documents = userDocumentService.findAllByUserId(userId);
            model.addAttribute("documents", documents);

            return "managedocuments";
        } else {

            System.out.println("Fetching file");

            User user = userService.findById(userId);
            model.addAttribute("user", user);

            saveDocument(fileBucket, user);

            return "redirect:/add-document-"+userId;
        }
    }

    private void saveDocument(FileBucket fileBucket, User user) throws IOException{

        UserDocument document = new UserDocument();

        MultipartFile multipartFile = fileBucket.getFile();

        document.setName(multipartFile.getOriginalFilename());
        document.setDescription(fileBucket.getDescription());
        document.setType(multipartFile.getContentType());
        document.setContent(multipartFile.getBytes());
        document.setUser(user);
        userDocumentService.saveDocument(document);
    }
}
