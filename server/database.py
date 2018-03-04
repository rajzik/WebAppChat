import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base, DeferredReflection
from sqlalchemy.orm import scoped_session, sessionmaker


connectionString = 'postgresql://postgres:admin@localhost/webapp'

engine = create_engine(connectionString)

dbSession = scoped_session(sessionmaker(autocommit=False,
                                         autoflush=False,
                                         bind=engine))

Base = declarative_base(cls=DeferredReflection)
Base.query = dbSession.query_property()