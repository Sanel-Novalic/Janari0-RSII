using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface IService<T, TSearch>
        where T : class
        where TSearch : BaseSearchObject
    {
        Task<IEnumerable<T>> Get(TSearch? search = null);
        Task<T?> GetById(int id);
    }
}
