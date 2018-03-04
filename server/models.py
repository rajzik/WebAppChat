
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, Table, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declared_attr
from database import Base, engine



#class AssociationTable(Base):
#    __tablename__ = 'Whispers'
#    id = Column(Integer, primary_key=True)
#    user_id1 = Column(ForeignKey('Users.id'))
#   user_id2 = Column(ForeignKey('Users.id'))


class FriendsModel(Base):
    __tablename__ = 'Friends'
    id = Column(Integer, primary_key=True)
    user_id1 = Column(ForeignKey('user.id'))
    user_id2 = Column(ForeignKey('user.id'))





class UserModel(Base):
    __tablename__ = 'Users'
    id = Column(Integer, primary_key=True)
    first_name = Column(String(255))
    last_name = Column(String)
    user_name = Column(String)
    is_super_user = Column(Boolean)
    password = Column(String)
#    def _get_friends(self):
 #       return object_session(self).query(UserModel).with_parent(self).join(FriendsModel.user_id1).join(FriendsModel.user_id2).all();
  #  friends = property(_get_friends)
    #friends = relationship('UserModel',
     #                      primaryjoin=remote(id),
      #                     viewonly=True) 
    #relationship("UserModel",
     #                      secondary=association_table,
      #                     primaryjoin=association_table.c.user_id1,
       #                    secondaryjoin=association_table.c.user_id2,
        #                   backref="left")




room_users_association_table = Table('Groups', Base.metadata,
    Column('room_id', Integer, ForeignKey('Rooms.id')),
    Column('user_id', Integer, ForeignKey('Users.id'))
)


class RoomModel(Base):
    __tablename__ = 'Rooms'
    id = Column(Integer, primary_key=True)
    room_name = Column(String)
    is_locked = Column(Boolean)
    last_active = Column(DateTime)
    admin_id = Column(ForeignKey('Users.id'))
    admin = relationship('UserModel', uselist=False)
    users = relationship('UserModel', 
                         secondary=room_users_association_table)

Base.prepare(engine);