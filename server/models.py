
from sqlalchemy import Column, Integer, String
from database import Base, engine


class PersonModel(Base):
    __tablename__ = 'person'
    uuid = Column(Integer, primary_key=True)

Base.prepare(engine);