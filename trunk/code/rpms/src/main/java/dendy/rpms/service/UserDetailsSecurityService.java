package dendy.rpms.service;

import dendy.rpms.domain.RoleEntity;
import dendy.rpms.domain.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("userDetailsSecurityService")
public class UserDetailsSecurityService implements UserDetailsService {
    @Autowired
    private IUserService service;

    @Override
    public UserEntity loadUserByUsername(String userName) throws UsernameNotFoundException {
        UserEntity user = service.getByName(userName);
        if (user == null) throw new UsernameNotFoundException("user not found");
        if (user.getStatus() == UserEntity.STATUS_NOT_ENABLE) throw new IllegalStateException("account forbidden");
        List<GrantedAuthority> authsList = new ArrayList<>();
        authsList.add(new SimpleGrantedAuthority("ROLE_USER"));

        for (RoleEntity roleEntity : user.getRoles()) {
            String roleCode = roleEntity.getCode();
            authsList.add(new SimpleGrantedAuthority(roleCode));
        }
        UserEntity res = new UserEntity(userName, user.getPassword(), authsList);
        res.setRoles(user.getRoles());
        res.setId(user.getId());
        res.setStatus(user.getStatus());
        res.setSex(user.getSex());
        res.setAge(user.getAge());
        res.setTrueName(user.getTrueName());
        return res;
    }

    public static void main(String[] args) {
        Md5PasswordEncoder encoder = new Md5PasswordEncoder();
        String pwd = encoder.encodePassword("123456", null);
        System.out.println(pwd);
    }
}
