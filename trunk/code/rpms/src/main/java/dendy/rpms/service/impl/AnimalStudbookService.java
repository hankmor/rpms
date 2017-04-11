package dendy.rpms.service.impl;

import dendy.rpms.constant.SystemConst;
import dendy.rpms.dao.AnimalDao;
import dendy.rpms.domain.StudbookData;
import dendy.rpms.entity.Animal;
import dendy.rpms.service.IAnimalStudbookService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

/**
 * <p>Created by Dendy on 2014/9/21.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Service
public class AnimalStudbookService implements IAnimalStudbookService {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(AnimalStudbookService.class);

    //~ Instance fields ================================================================================================

    @Autowired
    private AnimalDao animalDao;

    //~ Methods ========================================================================================================

    @Override
    public StudbookData loadDown(Long animalId) {
        Animal animal = animalDao.getWithChildrenAndAtta(animalId);
        StudbookData studbookData = new StudbookData();
        studbookData.setMicrochipCode(animal.getMicrochipCode());
        studbookData.setPhotoPath(animal.getAtta() == null ? "" : SystemConst.FILE_VISIT_URL + "/" + animal.getAtta().getPath());
        studbookData.setStudbookCode(animal.getStudbookCode());
        if (animal.getSex() != null)
            studbookData.setSex(animal.getSex() ? "▲" : "●");
        else
            studbookData.setSex("");
        studbookData.setName(animal.getName());
        listDown(animal, studbookData.getChildren());
        return studbookData;
    }

    private void listDown(Animal animal, List<StudbookData> children) {
        if (animal.getSex() != null) {
            Set<Animal> subAnimals;
            if (animal.getSex()) {
                subAnimals = animal.getAnimalsForFather();
            } else {
                subAnimals = animal.getAnimalsForMother();
            }
            for (Animal subAnimal : subAnimals) {
                StudbookData studbookData = setupStudbookData(children, subAnimal);
                // 递归
                listDown(subAnimal, studbookData.getChildren());
            }
        }
    }

    @Override
    public StudbookData loadUp(Long animalId) {
        Animal animal = animalDao.getWithParentsAndAtta(animalId);
        StudbookData studbookData = new StudbookData();
        studbookData.setMicrochipCode(animal.getMicrochipCode());
        studbookData.setPhotoPath(animal.getAtta() == null ? "" : SystemConst.FILE_VISIT_URL + "/" + animal.getAtta().getPath());
        studbookData.setStudbookCode(animal.getStudbookCode());
        if (animal.getSex() != null)
            studbookData.setSex(animal.getSex() ? "▲" : "●");
        else
            studbookData.setSex("");
        studbookData.setName(animal.getName());
        listUp(animal, studbookData.getChildren());
        return studbookData;
    }

    private void listUp(Animal animal, List<StudbookData> parents) {
        if (animal.getAnimalByFather() == null || animal.getAnimalByMother() == null)
            animal = animalDao.getWithParentsAndAtta(animal.getId());
        Animal father = animal.getAnimalByFather();
        Animal mother = animal.getAnimalByMother();
        if (father != null) {
            StudbookData studbookData = setupStudbookData(parents, father);
            listUp(father, studbookData.getChildren());
        }

        if (mother != null) {
            StudbookData studbookData = setupStudbookData(parents, mother);
            listUp(mother, studbookData.getChildren());
        }
    }

    private StudbookData setupStudbookData(List<StudbookData> children, Animal animal) {
        StudbookData studbookData = new StudbookData();
        studbookData.setMicrochipCode(animal.getMicrochipCode());
        studbookData.setPhotoPath(animal.getAtta() == null ? "" : SystemConst.FILE_VISIT_URL + "/" + animal.getAtta().getPath());
        studbookData.setStudbookCode(animal.getStudbookCode());
        if (animal.getSex() != null)
            studbookData.setSex(animal.getSex() ? "▲" : "●");
        else
            studbookData.setSex("");
        studbookData.setName(animal.getName());
        children.add(studbookData);
        return studbookData;
    }
}
