

"""
TODO: Add connection to db... should be easy task...
    see: https://medium.com/@fasterpancakes/graphql-server-up-and-running-with-50-lines-of-python-85e8ada9f637
    part with dat magic lul
TODO: Pagination maybe will be needed
    see: https://github.com/graphql-python/graphene/issues/469
"""
import graphene
from models import *

"""
 Description for types this will be moved to another file. so we have only schema here
"""
class PersonType(graphene.ObjectType):
    name = 'Person'
    description = '...'

    first_name = graphene.String();

"""
    Actual schema where we define our requests
    every entry has to have resolver, in format of resolve_<Name of column>
"""

class QueryType(graphene.ObjectType):
    name = 'Query'
    description = '...'
    
    person = graphene.Field(
        PersonType,
        id = graphene.String()
    )
    """
        btw I am little bit confused by named arguments,
        args are something else, but after that there are named arguments so I ame despared

    """
    def resolve_person(self, args, id):
        print(id)
        p = PersonType(first_name='peter');
        # id = args.pop('test', 0)
        return p


    
schema = graphene.Schema(query=QueryType)