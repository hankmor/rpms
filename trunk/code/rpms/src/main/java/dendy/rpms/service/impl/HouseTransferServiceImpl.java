package dendy.rpms.service.impl;

import dendy.rpms.constant.SystemConst;
import dendy.rpms.dao.HouseTransferDao;
import dendy.rpms.domain.HouseTransferEntity;
import dendy.rpms.entity.Animal;
import dendy.rpms.entity.House;
import dendy.rpms.entity.HouseTransfer;
import dendy.rpms.entity.User;
import dendy.rpms.service.IAnimalService;
import dendy.rpms.service.IHouseTransferService;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.UserUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * <p>Created by Dendy on 2014/8/28.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Service
public class HouseTransferServiceImpl implements IHouseTransferService {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(HouseTransferServiceImpl.class);

    //~ Instance fields ================================================================================================
    @Autowired
    private HouseTransferDao houseTransferDao;
    @Autowired
    private IAnimalService animalService;

    //~ Methods ========================================================================================================

    @Override
    @Transactional
    public void add(HouseTransfer houseTransfer) {
        Assert.notNull(houseTransfer);
        User createUser = UserUtil.getUserModel();
        houseTransfer.setUserByCreateUser(createUser);
        houseTransfer.setCreateTime(new Date());
        houseTransferDao.add(houseTransfer);
    }

    @Override
    @Transactional
    public void transOutToZoo(String ids, HouseTransfer houseTransfer) {
        Assert.hasLength(ids);
        Assert.notNull(houseTransfer);

        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            // 设置动物的状态为转出、当前圈舍为空.
            Long id = Long.parseLong(idArray[i]);
            Animal animal = animalService.get(id);
            House oldHouse = animal.getHouse();
            animal.setHouse(null);
            animal.setUpdateTime(new Date());
            animal.setUserByUpdateUser(UserUtil.getUserModel());
            animal.setStatus(SystemConst.ANIMAL_STATUS_TRANS_OUT);
            animalService.update(animal);

            // 增加转移记录
            HouseTransfer transfer = new HouseTransfer();
            transfer.setAnimal(animal);
            transfer.setHouseBySrcHouse(oldHouse);
            transfer.setZoo(houseTransfer.getZoo());
            transfer.setTransType(SystemConst.TRANS_OUT_TO_OTHER_ZOO);
            transfer.setTransTime(new Date());
            transfer.setCreateTime(new Date());
            transfer.setUserByCreateUser(UserUtil.getUserModel());
            transfer.setRemark(houseTransfer.getRemark());
            houseTransferDao.add(transfer);
        }
    }

    @Override
    @Transactional
    public void transOutToLocal(String ids, HouseTransfer houseTransfer) {
        Assert.hasLength(ids);
        Assert.notNull(houseTransfer);

        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            // 设置当前圈舍目标圈舍.
            Long id = Long.parseLong(idArray[i]);
            Animal animal = animalService.get(id);
            House oldHouse = animal.getHouse();
            animal.setHouse(houseTransfer.getHouseByDestHouse());
            animal.setUpdateTime(new Date());
            animal.setUserByUpdateUser(UserUtil.getUserModel());
            animalService.update(animal);

            // 增加转移记录
            HouseTransfer transfer = new HouseTransfer();
            transfer.setAnimal(animal);
            transfer.setHouseBySrcHouse(oldHouse);
            transfer.setHouseByDestHouse(houseTransfer.getHouseByDestHouse());
            transfer.setTransType(SystemConst.TRANS_OUT_TO_LOCAL_HOUSE);
            transfer.setTransTime(new Date());
            transfer.setCreateTime(new Date());
            transfer.setUserByCreateUser(UserUtil.getUserModel());
            transfer.setRemark(houseTransfer.getRemark());
            houseTransferDao.add(transfer);
        }
    }

    @Override
    public List<HouseTransferEntity> getTransRecords(Long id) {
        Assert.notNull(id);
        return houseTransferDao.getTransRecords(id);
    }
}
