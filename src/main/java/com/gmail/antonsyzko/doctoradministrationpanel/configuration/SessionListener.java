package com.gmail.antonsyzko.doctoradministrationpanel.configuration;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by Admin on 21.08.2016.
 * timeout for inactivity 30 * 60
 */
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        System.out.println("==== Session is created ==== " );
        event.getSession().setMaxInactiveInterval(30*60);//1800 seconds - half hour idle
        System.out.println(" max inactive  interval " + event.getSession().getMaxInactiveInterval());

    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        System.out.println("==== Session is destroyed ====");

    }
}

