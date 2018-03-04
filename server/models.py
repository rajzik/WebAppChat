
import graphene
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, Table
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declared_attr
from database import Base, engine

association_table = Table('Whispers', Base.metadata,
    Column('user_id1', ForeignKey('Users.id')),
    Column('user_id2', ForeignKey('Users.id'))
)




class UserModel(Base):
    __tablename__ = 'Users'
    id = Column(Integer, primary_key=True)
    first_name = Column(String)
    last_name = Column(String)
    user_name = Column(String)
    is_super_user = Column(Boolean)
    password = Column(String)
    #friends = relationship("UserModel",
    #                       secondary=association_table)


Base.prepare(engine);