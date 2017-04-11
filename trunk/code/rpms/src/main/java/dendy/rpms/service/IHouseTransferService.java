package dendy.rpms.service;

import dendy.rpms.domain.HouseTransferEntity;
import dendy.rpms.entity.HouseTransfer;

import java.util.List;

/**
 * 圈舍转移服务接口.
 * <p>Created by Dendy on 2014/8/28.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public interface IHouseTransferService {
    /**
     * 添加圈舍转移记录
     *
     * @param houseTransfer
     */
    void add(HouseTransfer houseTransfer);

    /**
     * 转出到别的园区
     *
     * @param ids           被转移动物的ids
     * @param houseTransfer 转移对象
     */
    void transOutToZoo(String ids, HouseTransfer houseTransfer);

    /**
     * 转移到本地圈舍
     *
     * @param ids           动物ids
     * @param houseTransfer 转移对象
     */
    void transOutToLocal(String ids, HouseTransfer houseTransfer);

    /**
     * 获取动物转移记录
     *
     * @param id 动物id
     * @return 转移记录信息
     */
    List<HouseTransferEntity> getTransRecords(Long id);
}
