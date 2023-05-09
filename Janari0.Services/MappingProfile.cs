using AutoMapper;
using Janari0.Model.Requests;
using Janari0.Services.Requests;

namespace Janari0.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile() {
            CreateMap<Database.User, Model.User>().ReverseMap();
            CreateMap<Database.Product, Model.Product>().ReverseMap();
            CreateMap<Database.ProductsSale, Model.ProductsSale>();
            CreateMap<Database.Photo, Model.Photo>().ReverseMap();
            CreateMap<Database.Location, Model.Location>().ReverseMap();
            CreateMap<Database.Seller, Model.Seller>();
            CreateMap<Database.Order, Model.Order>();
            CreateMap<Database.OrderItem, Model.OrderItem>();
            CreateMap<Database.Output, Model.Output>();
            CreateMap<Database.OutputItem, Model.OutputItem>();
            CreateMap<Database.Buyer, Model.Buyer>();
            CreateMap<Database.Seller, Model.Seller>();
            CreateMap<ProductInsertRequest, Database.Product>().ReverseMap();
            CreateMap<ProductUpdateRequest, Database.Product>();
            CreateMap<UserInsertRequest, Database.User>();
            CreateMap<UserUpdateRequest, Database.User>()
                .ForMember(dest => dest.Email, opt => opt.MapFrom((src, dest) => src.Email ?? dest.Email))
                .ForMember(dest => dest.PhoneNumber, opt => opt.MapFrom((src, dest) => src.PhoneNumber ?? dest.PhoneNumber))
                .ForMember(dest => dest.Uid, opt => opt.MapFrom((src, dest) => src.Uid ?? dest.Uid))
                .ForAllMembers(opts =>
                {
                    opts.Condition((src, dest, srcMember) => srcMember != null);
                });
            CreateMap<PhotoInsertRequest, Database.Photo>();
            CreateMap<PhotoUpdateRequest, Database.Photo>();
            CreateMap<LocationInsertRequest, Database.Location>();
            CreateMap<LocationUpdateRequest, Database.Location>()
                .ForAllMembers(opts =>
                {
                    opts.Condition((src, dest, srcMember) => srcMember != null);
                });
            CreateMap<ProductsSaleInsertRequest, Database.ProductsSale>();
            CreateMap<OutputUpsertRequest, Database.Output>().ForAllMembers(opts =>
            {
                opts.Condition((src, dest, srcMember) => srcMember != null);
            });
            CreateMap<OutputItemUpsertRequest, Database.OutputItem>().ForAllMembers(opts =>
            {
                opts.Condition((src, dest, srcMember) => srcMember != null);
            });
 
            CreateMap<OrderInsertRequest, Database.Order>();
            CreateMap<OrderUpdateRequest, Database.Order>().ForAllMembers(opts =>
            {
                opts.Condition((src, dest, srcMember) => srcMember != null);
            });
            CreateMap<OrderItemInsertRequest, Database.OrderItem>();
            CreateMap<OrderItemUpdateRequest, Database.OrderItem>().ForAllMembers(opts =>
            {
                opts.Condition((src, dest, srcMember) => srcMember != null);
            });
            CreateMap<SellerInsertRequest, Database.Seller>();
            CreateMap<SellerUpdateRequest, Database.Seller>().ForAllMembers(opts =>
            {
                opts.Condition((src, dest, srcMember) => srcMember != null);
            });
            CreateMap<BuyerInsertRequest, Database.Buyer>();
            CreateMap<BuyerUpdateRequest, Database.Buyer>().ForAllMembers(opts =>
            {
                opts.Condition((src, dest, srcMember) => srcMember != null);
            });
        }
        
    }
}
