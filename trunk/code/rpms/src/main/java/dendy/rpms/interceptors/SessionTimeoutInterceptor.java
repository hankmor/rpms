package dendy.rpms.interceptors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 判断session超时拦截器，处理ajax请求session超时时跳转登录页面
 *
 * @author Dendy
 * @since 2013年11月7日
 */
public class SessionTimeoutInterceptor extends HandlerInterceptorAdapter {
    private static final Logger LOG = LoggerFactory.getLogger(SessionTimeoutInterceptor.class);

    private boolean hasUrl(HttpServletRequest request, String url) {
        return request.getServletPath().indexOf(url) > -1;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
    throws Exception {
        Object o = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (o instanceof String) {
            if (!"anonymousUser".equalsIgnoreCase(String.valueOf(o))) {
                return true;
            }
        } else if (o instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) o;
            if (userDetails != null)
                return true;
        }

        LOG.debug("user in session :" + o);
        // 判断当前请求是否是ajax请求
        if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with")
                .equalsIgnoreCase("XMLHttpRequest")) {
            // 注册不过滤
            if (hasUrl(request, "/reg"))
                return super.preHandle(request, response, handler);
            // 在响应头设置session状态，前端检测该状态，超时则用js进行页面跳转
//            response.setHeader("sessionstatus", "timeout");
            response.getWriter().write("<script type=\"text/javascript\">\n" +
                    "    Dialog.warning(\"登录已经失效，请重新登录！\", \"登录超时\", function () {\n" +
                    "        window.location.href = getContentPath() + \"/portal/login.do\";\n" +
                    "    });\n" +
                    "</script>");
            return false;
        }
        return super.preHandle(request, response, handler);
    }
}
