package com.gmail.antonsyzko.doctoradministrationpanel.dao;

import com.gmail.antonsyzko.doctoradministrationpanel.model.UserProfile;

import java.util.List;


public interface UserProfileDao {

	List<UserProfile> findAll();
	
	UserProfile findByType(String type);
	
	UserProfile findById(int id);
}
