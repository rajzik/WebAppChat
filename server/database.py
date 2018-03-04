import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base, DeferredReflection
from sqlalchemy.orm import scoped_session, sessionmaker


connectionString = os.environ['DATABASE_URL']
# connectionString = 'postgresql://xsilhan2:$engr%@akela.mendelu.cz/xsilhan2'

engine = create_engine(connectionString, sslmode='require')

dbSession = scoped_session(sessionmaker(autocommit=False,
                                         autoflush=False,
                                         bind=engine))

Base = declarative_base(cls=DeferredReflection)
Base.query = dbSession.query_property()