package com.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
        String errMsg = exception.getMessage();
        request.setAttribute("error","error");
        request.setAttribute("exceptionMsg",errMsg);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/login/login.do");
        dispatcher.forward(request, response);		
		
		
	}

}
