package com.gmail.antonsyzko.doctoradministrationpanel.model;

import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.Locale;


public class FileBucket {

	Locale locale = Locale.getDefault();

	MultipartFile file;
	
	String description;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getDescription() {
		return description ;
	}

	public void setDescription(String description) {

		this.description = description + " \r\n    .  (  added on     " + new Date().toString() +" )";
	}


}