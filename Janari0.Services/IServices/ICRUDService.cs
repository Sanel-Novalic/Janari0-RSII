using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface ICRUDService<T, TSearch, TInsert, TUpdate> : IService<T, TSearch> where T : class where TInsert : class where TUpdate : class where TSearch : BaseSearchObject
    {
        T Insert(TInsert insert);
        T Update(int id, TUpdate update);
        T Delete(int id);
    }
}
