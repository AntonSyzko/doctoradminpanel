package com.gmail.antonsyzko.doctoradministrationpanel.service;

import com.gmail.antonsyzko.doctoradministrationpanel.model.User;

import java.util.List;


public interface UserService {
	
	User findById(int id);
	
	User findBySSO(String sso);
	
	void saveUser(User user);
	
	void updateUser(User user);
	
	void deleteUserBySSO(String sso);

	List<User> findAllUsers();
	
	boolean isUserSSOUnique(Integer id, String sso);







}