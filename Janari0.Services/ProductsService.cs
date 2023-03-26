using AutoMapper;
using Janari0.Model;
using Janari0.Services.Database;
using Janari0.Services.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Janari0.Services
{
    public class ProductsService : BaseCRUDService<Model.Product, Database.Product, ProductInsertRequest, ProductUpdateRequest>, IProductsService
    { 
        public ProductsService(Janari0Context context, IMapper mapper): base(context,mapper) {
        }
    }
}
