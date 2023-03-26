using AutoMapper;
using Janari0.Services.Database;

namespace Janari0.Services
{
    public class ProductsSaleService : BaseService<Model.ProductsSale, Database.ProductsSale>, IProductsSaleService
    {
        public ProductsSaleService(Janari0Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
