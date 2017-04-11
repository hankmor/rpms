package dendy.rpms.domain;

import dendy.rpms.entity.Role;
import dendy.rpms.entity.User;
import dendy.rpms.utils.CustomDateSerializerYMDHMS;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.springframework.security.core.GrantedAuthority;

import java.util.*;

/**
 * 系统用户
 *
 * @author Dendy
 * @since 14-2-18
 */
public class UserEntity extends org.springframework.security.core.userdetails.User {
    /**
     * 被删除
     */
    public static final int STATUS_DELETE = -1;
    /**
     * 启用
     */
    public static final int STATUS_ENABLE = 1;
    /**
     * 禁用
     */
    public static final int STATUS_NOT_ENABLE = 0;

    private Long id;
    // 用户名
    private String name;
    // 姓名
    private String trueName;
    // 性别
    private Boolean sex;
    // 年龄
    private Integer age;
    // 创建时间
    private Date createTime;
    // 状态
    private int status;
    // 角色
    private List<RoleEntity> roles;
    private String remark;

    public UserEntity(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

    public UserEntity(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
    }

    /**
     * 数据库Teacher转换为前端domain
     *
     * @param user            数据库model
     * @param transRole       转换教师角色信息
     * @return 转换后的domian对象
     */
    public static UserEntity toDomain(User user, boolean transRole) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        UserEntity userEntity = new UserEntity(user.getName(), user.getPassword(), authorities);
        userEntity.setTrueName(user.getTrueName());
        userEntity.setId(user.getId());
        userEntity.setAge(user.getAge());
        userEntity.setSex(user.getSex());
        userEntity.setStatus(user.getStatus());

        userEntity.setCreateTime(user.getCreateTime());
        if (transRole) {
            Set<Role> roles = user.getRoles();
            List<RoleEntity> roleEntities = new ArrayList<RoleEntity>();
            for (Role role : roles) {
                roleEntities.add(new RoleEntity(role));
            }
            userEntity.setRoles(roleEntities);
        }
        return userEntity;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTrueName() {
        return trueName;
    }

    public void setTrueName(String trueName) {
        this.trueName = trueName;
    }

    public Boolean getSex() {
        return sex;
    }

    public void setSex(Boolean sex) {
        this.sex = sex;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    @JsonSerialize(using = CustomDateSerializerYMDHMS.class)
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<RoleEntity> getRoles() {
        return roles;
    }

    public void setRoles(List<RoleEntity> roles) {
        this.roles = roles;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
