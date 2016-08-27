package com.gmail.antonsyzko.doctoradministrationpanel.configuration;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

public class AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { AppConfig.class };
	}
 
	@Override
	protected Class<?>[] getServletConfigClasses() {
		return null;
	}
 
	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}




	//timeout for inactivity 30 * 60
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		super.onStartup(servletContext);
		servletContext.addListener(new SessionListener());
	}







	/*
	from UploadsProject
	 */

	@Override
	protected void customizeRegistration(ServletRegistration.Dynamic registration) {
		registration.setMultipartConfig(getMultipartConfigElement());
	}

	private MultipartConfigElement getMultipartConfigElement(){

		MultipartConfigElement multipartConfigElement = new MultipartConfigElement(LOCATION, MAX_FILE_SIZE, MAX_REQUEST_SIZE, FILE_SIZE_THRESHOLD);

		return multipartConfigElement;
	}

    /*Set these variables for your project needs*/

	//	private static final String LOCATION = "D:\\IdeaProjects\\FileDownloadToDatabase\\src\\main\\resources\\FilesStorage";
	private static final String LOCATION = null;

	private static final long MAX_FILE_SIZE = 1024 * 1024 * 64;//25MB

	private static final long MAX_REQUEST_SIZE = 1024 * 1024 * 64;//30MB

	private static final int FILE_SIZE_THRESHOLD = 0;
}
