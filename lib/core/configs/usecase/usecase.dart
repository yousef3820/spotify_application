abstract class Usecase<Type,Params> {
  Future<Type> execute({Params params});
}