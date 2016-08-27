package com.gmail.antonsyzko.doctoradministrationpanel.service;

import com.gmail.antonsyzko.doctoradministrationpanel.model.UserProfile;

import java.util.List;


public interface UserProfileService {

	UserProfile findById(int id);

	UserProfile findByType(String type);
	
	List<UserProfile> findAll();
	
}
