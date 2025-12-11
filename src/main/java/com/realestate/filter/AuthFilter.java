package com.realestate.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // Các trang public không cần đăng nhập
        String[] publicPaths = {"/login", "/register", "/", "/properties", "/property-detail", 
                                "/assets/", "/css/", "/js/", "/images/"};
        
        boolean isPublic = false;
        for (String publicPath : publicPaths) {
            if (path.startsWith(publicPath)) {
                isPublic = true;
                break;
            }
        }
        
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        // Nếu là trang public hoặc đã đăng nhập -> cho qua
        if (isPublic || isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            // Chưa đăng nhập -> redirect về login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}