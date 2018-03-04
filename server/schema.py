

import graphene
from graphene_sqlalchemy import SQLAlchemyConnectionField, SQLAlchemyObjectType
from models import *

"""
 Description for types this will be moved to another file. so we have only schema here
"""
class UserType(SQLAlchemyObjectType):
    
    class Meta:
        model = UserModel

class RoomType(SQLAlchemyObjectType):
    class Meta:
        model = RoomModel;

"""
    Actual schema where we define our requests
    every entry has to have resolver, in format of resolve_<Name of column>
"""

class QueryType(graphene.ObjectType):
    name = 'Query'
    description = '...'
    users = graphene.List(UserType)
    user = graphene.Field(UserType, id = graphene.Int())
    rooms = graphene.List(RoomType);

    def resolve_users(root, info):
        query = UserType.get_query(info)
        return query.all();
    
    def resolve_user(root, info, id):
        query = UserType.get_query(info)
        return query.get(id)

    def resolve_rooms(root, info):
        query = RoomType.get_query(info)
        return query.all();




    
schema = graphene.Schema(query=QueryType)


"""
TODO: Pagination maybe itll be needed
    see: https://github.com/graphql-python/graphene/issues/469
"""
