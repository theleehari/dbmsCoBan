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
    
    public partial class Phong
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Phong()
        {
            this.Thues = new HashSet<Thue>();
        }
    
        public int stt { get; set; }
        public string maphong { get; set; }
        public string loaiphong { get; set; }
        public string capdo { get; set; }
        public decimal giaphong { get; set; }
        public string tinhtrang { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Thue> Thues { get; set; }
    }
}
