package dendy.rpms.service.impl;

import dendy.rpms.dao.AttaDao;
import dendy.rpms.entity.Atta;
import dendy.rpms.entity.User;
import dendy.rpms.service.IAttaService;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * 附件服务实现
 *
 * @author Dendy
 * @since 14-2-21
 */
@Service
public class AttaServiceImpl implements IAttaService {
    @Autowired
    private AttaDao dao;

    @Override
    public Atta get(Long id) {
        Assert.notNull(id);
        return dao.get(id);
    }

    @Override
    @Transactional
    public void update(Atta atta) {
        Assert.notNull(atta);
        Atta src = dao.get(atta.getId());
        src.setName(atta.getName());
        src.setDescription(atta.getDescription());
        src.setRemark(atta.getRemark());
        // 修改人
        User updateUser = UserUtil.getUserModel();
        src.setUserByUpdateUser(updateUser);
        src.setUpdateTime(new Date());
        dao.update(src);
    }

    @Override
    @Transactional
    public void add(Atta atta) {
        Assert.notNull(atta);
        dao.save(atta);
    }

    @Override
    @Transactional
    public void delete(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        List<Atta> attas = new LinkedList<>();
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            Atta atta = dao.get(id);
            attas.add(atta);
        }
        dao.deleteAll(attas);
    }
}
