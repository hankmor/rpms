package test.dao;

import dendy.rpms.dao.AnimalTypeDao;
import dendy.rpms.dao.UserDao;
import dendy.rpms.domain.AnimalTypeEntity;
import dendy.rpms.entity.AnimalType;
import dendy.rpms.entity.User;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;
import test.base.BaseTest;

import java.util.Date;
import java.util.List;

/**
 * <p>Created by Dendy on 2014/8/26.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Transactional
@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = true)
public class TestAnimalTypeDao extends BaseTest {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(TestAnimalTypeDao.class);

    //~ Instance fields ================================================================================================
    @Autowired
    private AnimalTypeDao animalTypeDao;
    @Autowired
    private UserDao userDao;

    //~ Methods ========================================================================================================

    @Test
    @Rollback(false)
    public void testAdd() throws Exception {
        AnimalType animalType = new AnimalType();
        User user = userDao.getByName("admin");
        animalType.setName("小熊猫");
        animalType.setCreateTime(new Date());
        animalType.setUserByCreateUser(user);
        animalTypeDao.add(animalType);
        AnimalType animalType1 = new AnimalType();
        animalType1.setName("丹顶鹤");
        animalType1.setCreateTime(new Date());
        animalType1.setUserByCreateUser(user);
        animalTypeDao.add(animalType1);
    }

    @Test
    public void testGetAll() throws Exception {
        List<AnimalTypeEntity> animalTypeList = animalTypeDao.getAll();
        assertTrue(animalTypeList != null && animalTypeList.size() == 2);
    }

    @Test
    public void testGet() throws Exception {
        AnimalType animalType = animalTypeDao.get(AnimalType.class, 1L);
        assertTrue(animalType != null);
    }

    private void update() {
        AnimalType animalType = animalTypeDao.get(1L);
        animalType.setName("xxx");
        animalTypeDao.update(animalType);
    }

    @Test
    public void testUpdate() {
        update();
        AnimalType animalType = animalTypeDao.get(1L);
        assertTrue("xxx".equals(animalType.getName()));
    }
}
