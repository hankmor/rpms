package dendy.rpms.domain;

import dendy.rpms.entity.Role;

/**
 * 系统角色
 *
 * @author Dendy
 * @since 14-2-18
 */
public class RoleEntity {
    private Long id;
    private String name;
    private String code;

    public RoleEntity() {
    }

    public RoleEntity(Role role) {
        this.id = role.getId();
        this.name = role.getName();
        this.code = role.getCode();
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
