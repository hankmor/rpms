package dendy.rpms.interceptors;

import dendy.rpms.constant.SystemConst;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 应用程序path拦截器，为所有资源加上path
 *
 * @author dendy
 * @since 2013-10-9
 */
public class ContextPathInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        request.getSession().getServletContext()
                .setAttribute(SystemConst.SYSTEM_CONTEXT_PATH_KEY, SystemConst.SYSTEM_CONTEXT_PATH);
        // 设置浏览器不缓存页面信息
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.addHeader("Cache-Control", "no-cache");
        return super.preHandle(request, response, handler);
    }
}
