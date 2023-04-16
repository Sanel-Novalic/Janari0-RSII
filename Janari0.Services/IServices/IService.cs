using Janari0.Model.SearchObjects;

namespace Janari0.Services.IServices
{
    public interface IService<T, TSearch> where T : class where TSearch : BaseSearchObject
    {
        IEnumerable<T> Get(TSearch? search = null);
        T GetById(int id);
    }
}
