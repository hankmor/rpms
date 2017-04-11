package test.service;

import dendy.rpms.domain.AnimalTypeEntity;
import dendy.rpms.page.Pager;
import dendy.rpms.query.AnimalTypeQuery;
import dendy.rpms.service.IAnimalTypeService;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import test.base.BaseTest;

import java.util.List;

/**
 * <p>Created by Dendy on 2014/8/27.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Transactional
public class TestAnimalTypeService extends BaseTest {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(TestAnimalTypeService.class);

    //~ Instance fields ================================================================================================
    @Autowired
    private IAnimalTypeService animalTypeService;

    //~ Methods ========================================================================================================

    @Test
    public void testPage() throws Exception {
        AnimalTypeQuery animalTypeQuery = new AnimalTypeQuery();
        animalTypeQuery.setPage(1);
        animalTypeQuery.setRows(10);
        Pager<AnimalTypeEntity> animalTypeEntities = animalTypeService.page(animalTypeQuery);
        System.out.println(animalTypeEntities.getRows());
        assertTrue(animalTypeEntities != null && animalTypeEntities.getRows().size() == 2);
    }

    @Test
    public void testList() throws Exception {
        List<AnimalTypeEntity> animalTypes = animalTypeService.list();
        assertTrue(animalTypes != null && animalTypes.size() == 2);
    }
}
