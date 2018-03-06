
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, Table, DateTime
from sqlalchemy.orm import relationship, aliased
from sqlalchemy.ext.declarative import declared_attr
from database import Base, engine


# FIXME: All commented code is broken

"""
messagesRelation = Table('Association_messages', Base.metadata, 
                     Column('user1_id', ForeignKey('Users.id')),
                     Column('user2_id', ForeignKey('Users.id')))
                     """


friendsRelation = Table('Friends', Base.metadata, 
                     Column('user_id', ForeignKey('Users.id')),
                     Column('friend_id', ForeignKey('Users.id')))
"""
class Messages(Base):
    __tablename__ = 'Messages'
    id = Column(Integer, primary_key=True)
    message = Column(String(1000))
    timestamp = Column(DateTime)
    """
    


class UserModel(Base):
    __tablename__ = 'Users'
    id = Column(Integer, primary_key=True)
    first_name = Column(String(255))
    last_name = Column(String)
    user_name = Column(String)
    is_super_user = Column(Boolean)
    password = Column(String)
    """
    messages = relationship('Messages',
                            secondary='messagesRelation',
                            primaryjoin= id == messagesRelation.c.user1_id or id == messagesRelation.c.user2_id,
                            order_by=Messages.timestamp,
                            backref="Messages",
                            lazy='dynamic')
                            """
    friends = relationship('UserModel',
                          secondary=friendsRelation,
                          primaryjoin=id == friendsRelation.c.user_id,
                          secondaryjoin=id == friendsRelation.c.friend_id,
                          lazy = 'dynamic')
       
 

room_users_association_table = Table('Groups', Base.metadata,
    Column('room_id', Integer, ForeignKey('Rooms.id')),
    Column('user_id', Integer, ForeignKey('Users.id')))


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