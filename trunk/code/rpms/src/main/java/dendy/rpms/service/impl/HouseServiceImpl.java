package dendy.rpms.service.impl;

import dendy.rpms.dao.AnimalDao;
import dendy.rpms.dao.HouseDao;
import dendy.rpms.domain.HouseEntity;
import dendy.rpms.entity.Animal;
import dendy.rpms.entity.House;
import dendy.rpms.entity.User;
import dendy.rpms.page.Pager;
import dendy.rpms.page.PagerUtil;
import dendy.rpms.query.HouseQuery;
import dendy.rpms.service.IHouseService;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * 圈舍服务实现
 *
 * @author Dendy
 * @since 14-2-21
 */
@Service
public class HouseServiceImpl implements IHouseService {
    @Autowired
    private HouseDao dao;
    @Autowired
    private AnimalDao animalDao;

    @Override
    public House get(Long id) {
        Assert.notNull(id);
        return dao.get(House.class, id);
    }

    @Override
    public House getByNo(String no) {
        Assert.hasLength(no);
        return dao.getByCode(no);
    }

    @Override
    @Transactional
    public void update(House house) {
        Assert.notNull(house);
        House src = dao.get(house.getId());
        src.setName(house.getName());
        src.setDescription(house.getDescription());
        src.setRemark(house.getRemark());
        src.setLocation(house.getLocation());
        // 修改人
        User updateUser = UserUtil.getUserModel();
        src.setUserByUpdateUser(updateUser);
        src.setUpdateTime(new Date());
        dao.update(src);
    }

    @Override
    @Transactional
    public void add(House house) {
        Assert.notNull(house);

        User createUser = UserUtil.getUserModel();
        house.setUserByCreateUser(createUser);
        house.setCreateTime(new Date());
        dao.save(house);
    }

    @Override
    @Transactional
    public void delete(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        List<House> houses = new LinkedList<>();
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            House house = dao.get(House.class, id);
            houses.add(house);
        }
        dao.deleteAll(houses);
    }

    @Override
    public Pager<HouseEntity> page(HouseQuery houseQuery) {
        Assert.notNull(houseQuery, "houseQuery object must not be null!");
        int beginNum = PagerUtil.getPageStart(houseQuery.getPage(), houseQuery.getRows());
        return dao.findPagerData(houseQuery.projectionList(), houseQuery.getDomainClass(), houseQuery.getDetachedCriteria(), beginNum, houseQuery.getRows());
    }

    @Override
    @Transactional
    public void addMembers(Long houseId, String ids) {
        Assert.notNull(houseId);
        Assert.hasLength(ids);
        House house = dao.get(House.class, houseId);
        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            Animal animal = animalDao.get(Animal.class, id);
            animal.setHouse(house);
            animalDao.update(animal);
        }
        dao.update(house);
    }

    @Override
    @Transactional
    public void deleteMembers(Long houseId, String ids) {
        Assert.notNull(houseId);
        Assert.hasLength(ids);
        House house = dao.get(House.class, houseId);
        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            Animal animal = animalDao.get(Animal.class, id);
            animal.setHouse(null);
            animalDao.update(animal);
        }
        dao.update(house);
    }
}
