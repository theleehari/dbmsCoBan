//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace QuanLyKhachSan
{
    using System;
    using System.Collections.Generic;
    
    public partial class Nhanvien
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Nhanvien()
        {
            this.Khachhangs = new HashSet<Khachhang>();
            this.Thues = new HashSet<Thue>();
        }
    
        public int manv { get; set; }
        public string ho { get; set; }
        public string tenlot { get; set; }
        public string tennv { get; set; }
        public Nullable<System.DateTime> ngaysinh { get; set; }
        public string sdt { get; set; }
        public string chucvu { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Khachhang> Khachhangs { get; set; }
        public virtual Taikhoan Taikhoan { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Thue> Thues { get; set; }
    }
}