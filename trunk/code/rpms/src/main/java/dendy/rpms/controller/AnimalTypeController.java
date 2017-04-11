package dendy.rpms.controller;

import dendy.rpms.domain.AnimalTypeEntity;
import dendy.rpms.domain.SelectObject;
import dendy.rpms.service.IAnimalTypeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * 动物类型控制器.
 * <p>Created by Dendy on 2014/8/26.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Controller
@RequestMapping("/at")
public class AnimalTypeController {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(AnimalTypeController.class);

    //~ Instance fields ================================================================================================
    @Autowired
    private IAnimalTypeService animalTypeService;

    //~ Methods ========================================================================================================

    @RequestMapping("/list")
    @ResponseBody
    public List<SelectObject> getAll() {
        try {
            List<SelectObject> selectObjects = new LinkedList<>();
            List<AnimalTypeEntity> animalTypeEntities = animalTypeService.list();
            for (int i = 0; i < animalTypeEntities.size(); i++) {
                AnimalTypeEntity animalTypeEntity = animalTypeEntities.get(i);
                selectObjects.add(new SelectObject(animalTypeEntity.getId(), animalTypeEntity.getName()));
            }
            return selectObjects;
        } catch (Exception e) {
            LOG.error("list animal types failed : ", e);
        }
        return new ArrayList<>();
    }
}
