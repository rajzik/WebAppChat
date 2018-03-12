
import graphene

from userModel import User

class UserType(graphene.ObjectType):
    id = graphene.ID()
    first_name = graphene.String()
    last_name = graphene.String()
    friends = graphene.List(lambda: UserType, description='Mostly less strange people')
    user_name = graphene.String(description='Something you forget often')

    def resolve_friends(self, args):
        return self.friends.all()

class QueryType(graphene.ObjectType):
    all_users = graphene.List(UserType, description='A few billion people')
    user = graphene.Field(
        UserType,
        id=graphene.ID(),
        description='Just one person belonging to an ID',
    )

    def resolve_all_user(self, context):
        return User.objects.all()

    def resolve_user(self, context, id):
        return User.objects.get(pk=id)

schema = graphene.Schema(query=QueryType)