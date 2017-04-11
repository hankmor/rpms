package test.utils;

import dendy.rpms.entity.Animal;
import dendy.rpms.entity.House;
import dendy.rpms.entity.User;
import org.apache.commons.beanutils.BeanUtils;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;

/**
 * <p>Created by Dendy on 2014/8/28.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class TestBeanUtils {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(TestBeanUtils.class);

    //~ Instance fields ================================================================================================

    //~ Methods ========================================================================================================
    @Test
    public void testCopy() throws Exception {
        Animal animal = new Animal();

        House house = new House();
        house.setId(1L);
        house.setName("house");

        User user = new User();
        user.setId(1L);
        user.setName("admin");

        animal.setUserByCreateUser(user);
        animal.setCreateTime(new Date());
        animal.setHouse(house);
        animal.setId(1L);
        animal.setName("haha");

        Animal dest = new Animal();
        House newHouse = new House();
        newHouse.setId(2L);
        newHouse.setName("new House");

        animal.setName("xixi");
        animal.setHouse(newHouse);

        BeanUtils.copyProperties(dest, animal);
        System.out.println(dest.getId());
        System.out.println(dest.getName());
        System.out.println(dest.getHouse().getId());
        System.out.println(dest.getHouse().getName());
        System.out.println(dest.getUserByCreateUser());
    }
}
