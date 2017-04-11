package dendy.rpms.controller;

import dendy.rpms.constant.SystemConst;
import dendy.rpms.domain.RoleEntity;
import dendy.rpms.domain.UserEntity;
import dendy.rpms.message.BaseMessage;
import dendy.rpms.page.Pager;
import dendy.rpms.query.UserQuery;
import dendy.rpms.service.IRoleService;
import dendy.rpms.service.IUserService;
import dendy.rpms.utils.MD5Util;
import dendy.rpms.utils.UserUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * 系统用户
 *
 * @author Dendy
 * @since 14-2-20
 */
@Controller
@RequestMapping("/user")
public class UserController {
    private static final Logger LOG = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private IUserService userService;
    @Autowired
    private IRoleService roleService;

    @RequestMapping(value = "/init", method = RequestMethod.POST)
    public String init() {
        return "/user/user";
    }

    @RequestMapping(value = "/toUpdatePage", method = RequestMethod.POST)
    public String toUpdatePage() {
        return "/user/update";
    }

    @RequestMapping(value = "/toAddPage", method = RequestMethod.POST)
    public String toAddPage() {
        return "/user/add";
    }

    @RequestMapping(value = "/editPwd", method = RequestMethod.POST)
    public String editPwd() {
        return "/user/editpwd";
    }


    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage update(HttpServletRequest request) {
        try {
            String id = request.getParameter("id");
            Long userId = Long.parseLong(id);
            UserEntity userEntity = userService.get(userId);

            String TrueName = request.getParameter("trueName");
            String sex = request.getParameter("sex");
            String age = request.getParameter("age");

            String[] roles = request.getParameterValues("role");
            List<RoleEntity> roleEntities = null;
            if (roles != null && roles.length > 0) {
                roleEntities = new LinkedList<>();
                for (int i = 0; i < roles.length; i++) {
                    String roleCode = roles[i];
                    RoleEntity roleEntity = roleService.getByRoleCode(roleCode, false);
                    roleEntities.add(roleEntity);
                }
            }

            userEntity.setTrueName(TrueName);
            userEntity.setAge(Integer.parseInt(age));
            userEntity.setSex(Boolean.parseBoolean(sex));
            if (roleEntities != null)
                userEntity.setRoles(roleEntities);
            userService.update(userEntity);
            return BaseMessage.successMessage("修改成功！");
        } catch (Exception e) {
            LOG.error("update user error :", e);
            return BaseMessage.errorMessage("修改失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage add(HttpServletRequest request) {
        try {
            String username = request.getParameter("username").trim();
            UserEntity userEntity = userService.getByName(username);
            if (userEntity != null)
                return BaseMessage.warnMessage("用户名已经存在！");
            String TrueName = request.getParameter("trueName").trim();
            String sex = request.getParameter("sex").trim();
            String age = request.getParameter("age").trim();

            List<GrantedAuthority> authorities = new ArrayList<>();
            String[] roles = request.getParameterValues("role");
            List<RoleEntity> roleEntities = new LinkedList<>();
            for (int i = 0; i < roles.length; i++) {
                String roleCode = roles[i];
                RoleEntity roleEntity = roleService.getByRoleCode(roleCode, false);
                roleEntities.add(roleEntity);
                authorities.add(new SimpleGrantedAuthority(roleCode));
            }
            authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

            userEntity = new UserEntity(username, MD5Util.encrypt(SystemConst.DEFAULT_PASSWORD), authorities);
            userEntity.setTrueName(TrueName);
            userEntity.setAge(Integer.parseInt(age));
            userEntity.setSex(Boolean.parseBoolean(sex));
            userEntity.setRoles(roleEntities);

            userService.add(userEntity);
            return BaseMessage.successMessage("添加成功！");
        } catch (Exception e) {
            LOG.error("add user error : ", e);
            return BaseMessage.errorMessage("添加失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage delete(String ids) {
        try {
            userService.delete(ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete user error : ", e);
            return BaseMessage.errorMessage("删除失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/resetPwd", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage resetPwd(String ids) {
        try {
            userService.resetPwd(ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("reset user password error : ", e);
            return BaseMessage.errorMessage("删除失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/setUsing", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage setUsing(String ids) {
        try {
            userService.setUsing(ids);
            return BaseMessage.successMessage("设置成功！");
        } catch (Exception e) {
            LOG.error("set user enable error : ", e);
            return BaseMessage.errorMessage("设置失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/setForbidden", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage setForbidden(String ids) {
        try {
            userService.setForbidden(ids);
            return BaseMessage.successMessage("设置成功！");
        } catch (Exception e) {
            LOG.error("set user not enable error : ", e);
            return BaseMessage.errorMessage("设置失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/updatePwd", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage editCurrentUserPwd(String oldPwd, String newPwd) {
        try {
            UserEntity loginUser = userService.get(UserUtil.getUser().getId());
            String curPwd = loginUser.getPassword();
            if (MD5Util.encrypt(oldPwd).equals(curPwd)) {
                userService.editCurrentUserPwd(loginUser.getId(), MD5Util.encrypt(newPwd));
                return BaseMessage.successMessage("密码修改成功，请重新登录！");
            } else
                return BaseMessage.errorMessage("原始密码错误，请重新输入！");
        } catch (Exception e) {
            LOG.error("update user password error : ", e);
            return BaseMessage.errorMessage("修改密码失败!");
        }
    }

    /**
     * 查询用户信息
     *
     * @param userQuery 查询表单
     * @return 分页对象
     */
    @RequestMapping(value = "/pager", method = RequestMethod.POST)
    @ResponseBody
    public Pager<UserEntity> pager(UserQuery userQuery) {
        try {
            return userService.page(userQuery);
        } catch (Exception e) {
            LOG.error("Query users has exception : ", e);
            return new Pager<UserEntity>(0);
        }
    }

    /**
     * 检查用户名是否重复
     *
     * @param username
     * @return
     */
    @RequestMapping(value = "/same", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkSameUserName(String username) {
        try {
            UserEntity userEntity = userService.getByName(username);
            if (userEntity != null)
                return true;
            return false;
        } catch (Exception e) {
            LOG.error("Query users has exception : ", e);
            return true;
        }
    }
}
