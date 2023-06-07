<template>
    <div class="row">
        <div class="col-md-12">
            <form>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.codigo,
                            }"
                            >Código*</label
                        >
                        <el-input
                            placeholder="Código"
                            :class="{
                                'is-invalid': errors.codigo,
                            }"
                            v-model="oRepuesto.codigo"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.codigo"
                            v-text="errors.codigo[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.nombre,
                            }"
                            >Nombre*</label
                        >
                        <el-input
                            placeholder="Nombre"
                            :class="{
                                'is-invalid': errors.nombre,
                            }"
                            v-model="oRepuesto.nombre"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.nombre"
                            v-text="errors.nombre[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.descripcion,
                            }"
                            >Descripción*</label
                        >
                        <el-input
                            type="textarea"
                            autosize
                            placeholder="Descripción"
                            :class="{
                                'is-invalid': errors.descripcion,
                            }"
                            v-model="oRepuesto.descripcion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.descripcion"
                            v-text="errors.descripcion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.marca,
                            }"
                            >Marca</label
                        >
                        <el-input
                            placeholder="Marca"
                            :class="{
                                'is-invalid': errors.marca,
                            }"
                            v-model="oRepuesto.marca"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.marca"
                            v-text="errors.marca[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.modelo,
                            }"
                            >Modelo</label
                        >
                        <el-input
                            placeholder="Modelo"
                            :class="{
                                'is-invalid': errors.modelo,
                            }"
                            v-model="oRepuesto.modelo"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.modelo"
                            v-text="errors.modelo[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.serie,
                            }"
                            >Serie</label
                        >
                        <el-input
                            placeholder="Código"
                            :class="{
                                'is-invalid': errors.serie,
                            }"
                            v-model="oRepuesto.serie"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.serie"
                            v-text="errors.serie[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS DE DEPENDENCIA
                        </h3>
                        <hr class="col-md-12" />
                        <div class="form-group col-md-12">
                            <label
                                :class="{
                                    'text-danger': errors.equipo_id,
                                }"
                                >Seleccionar equipo*</label
                            >
                            <el-select
                                placeholder="Seleccionar equipo"
                                class="w-100"
                                :class="{
                                    'is-invalid': errors.equipo_id,
                                }"
                                v-model="oRepuesto.equipo_id"
                                clearable
                            >
                                <el-option
                                    v-for="item in listEquipos"
                                    :key="item.id"
                                    :value="item.id"
                                    :label="item.codigo + ' | ' + item.nombre"
                                ></el-option>
                            </el-select>
                            <span
                                class="error invalid-feedback"
                                v-if="errors.equipo_id"
                                v-text="errors.equipo_id[0]"
                            ></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS DE INVENTARIO
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.precio,
                            }"
                            >Precio*</label
                        >
                        <el-input
                            type="number"
                            placeholder="Precio"
                            :class="{
                                'is-invalid': errors.precio,
                            }"
                            v-model="oRepuesto.precio"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.precio"
                            v-text="errors.precio[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.stock_min,
                            }"
                            >Stock Mínimo*</label
                        >
                        <el-input
                            type="number"
                            placeholder="Stock Mínimo"
                            :class="{
                                'is-invalid': errors.stock_min,
                            }"
                            v-model="oRepuesto.stock_min"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.stock_min"
                            v-text="errors.stock_min[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.stock_max,
                            }"
                            >Stock Máximo*</label
                        >
                        <el-input
                            type="number"
                            placeholder="Stock Máximo"
                            :class="{
                                'is-invalid': errors.stock_max,
                            }"
                            v-model="oRepuesto.stock_max"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.stock_max"
                            v-text="errors.stock_max[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.unidad_medida,
                            }"
                            >Unidad de medida</label
                        >
                        <el-input
                            placeholder="Unidad de medida"
                            :class="{
                                'is-invalid': errors.unidad_medida,
                            }"
                            v-model="oRepuesto.unidad_medida"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.unidad_medida"
                            v-text="errors.unidad_medida[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS DE PROVEEDOR
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.dir,
                            }"
                            >Dirección</label
                        >
                        <el-input
                            placeholder="Dirección"
                            :class="{
                                'is-invalid': errors.dir,
                            }"
                            v-model="oRepuesto.dir"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.dir"
                            v-text="errors.dir[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.fono,
                            }"
                            >Teléfono</label
                        >
                        <el-input
                            placeholder="Teléfono"
                            :class="{
                                'is-invalid': errors.fono,
                            }"
                            v-model="oRepuesto.fono"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fono"
                            v-text="errors.fono[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.correo,
                            }"
                            >Correo electrónico</label
                        >
                        <el-input
                            placeholder="Correo electrónico"
                            :class="{
                                'is-invalid': errors.correo,
                            }"
                            v-model="oRepuesto.correo"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.correo"
                            v-text="errors.correo[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS DE UBICACIÓN
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-12">
                        <label
                            :class="{
                                'text-danger': errors.almacen,
                            }"
                            >Almacén*</label
                        >
                        <el-input
                            placeholder="Almacén"
                            :class="{
                                'is-invalid': errors.almacen,
                            }"
                            v-model="oRepuesto.almacen"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.almacen"
                            v-text="errors.almacen[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS DE TERCEROS
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.fabricante,
                            }"
                            >Fabricante</label
                        >
                        <el-input
                            placeholder="Fabricante"
                            :class="{
                                'is-invalid': errors.fabricante,
                            }"
                            v-model="oRepuesto.fabricante"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fabricante"
                            v-text="errors.fabricante[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.proveedor,
                            }"
                            >Proveedor</label
                        >
                        <el-input
                            placeholder="Proveedor"
                            :class="{
                                'is-invalid': errors.proveedor,
                            }"
                            v-model="oRepuesto.proveedor"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.proveedor"
                            v-text="errors.proveedor[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.terciarios,
                            }"
                            >Terciarios</label
                        >
                        <el-input
                            placeholder="Terciarios"
                            :class="{
                                'is-invalid': errors.terciarios,
                            }"
                            v-model="oRepuesto.terciarios"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.terciarios"
                            v-text="errors.terciarios[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.nombre_contacto,
                            }"
                            >Nombre Contacto</label
                        >
                        <el-input
                            placeholder="Nombre Contacto"
                            :class="{
                                'is-invalid': errors.nombre_contacto,
                            }"
                            v-model="oRepuesto.nombre_contacto"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.nombre_contacto"
                            v-text="errors.nombre_contacto[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.num_fono,
                            }"
                            >Número de teléfono</label
                        >
                        <el-input
                            placeholder="Número de teléfono"
                            :class="{
                                'is-invalid': errors.num_fono,
                            }"
                            v-model="oRepuesto.num_fono"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.num_fono"
                            v-text="errors.num_fono[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.correo_fabricante,
                            }"
                            >Correo electrónico</label
                        >
                        <el-input
                            placeholder="Correo electrónico"
                            :class="{
                                'is-invalid': errors.correo_fabricante,
                            }"
                            v-model="oRepuesto.correo_fabricante"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.correo_fabricante"
                            v-text="errors.correo_fabricante[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.dir_fabricante,
                            }"
                            >Dirección</label
                        >
                        <el-input
                            placeholder="Dirección"
                            :class="{
                                'is-invalid': errors.dir_fabricante,
                            }"
                            v-model="oRepuesto.dir_fabricante"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.dir_fabricante"
                            v-text="errors.dir_fabricante[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.num_identificacion,
                            }"
                            >Número de identificación</label
                        >
                        <el-input
                            placeholder="Número de identificación"
                            :class="{
                                'is-invalid': errors.num_identificacion,
                            }"
                            v-model="oRepuesto.num_identificacion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.num_identificacion"
                            v-text="errors.num_identificacion[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <el-button
                            type="primary"
                            class="bg-primary"
                            :loading="enviando"
                            @click="setRegistro()"
                            >{{ textoBoton }}</el-button
                        >
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        repuesto: {
            type: Object,
            default: {
                id: 0,
                codigo: "",
                nombre: "",
                descripcion: "",
                marca: "",
                modelo: "",
                serie: "",
                equipo_id: "",
                precio: "",
                stock_min: "",
                stock_max: "",
                unidad_medida: "",
                dir: "",
                fono: "",
                correo: "",
                almacen: "",
                fabricante: "",
                proveedor: "",
                terciarios: "",
                nombre_contacto: "",
                num_fono: "",
                correo_fabricante: "",
                dir_fabricante: "",
                num_identificacion: "",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
        repuesto(newVal) {
            this.oRepuesto = newVal;
        },
    },
    computed: {
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            oRepuesto: this.repuesto,
            listEquipos: [],
            listPrioridad: [
                "P1-URGENTE",
                "P2-ALTA",
                "P3-MEDIA",
                "P4-BAJA",
                "P5-MINIMA",
            ],
            listUbicacion: ["PRODUCCIÓN", "PATIO", "CALDERAS", "OTROS"],
            listTipo: ["REFRIGERACIÓN", "COMPRESIÓN", "OTROS"],
            listEstado: ["ACTIVA", "INACTIVA", "INDISPUESTA"],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getEquipos();
    },
    methods: {
        getEquipos() {
            axios.get("/admin/equipos").then((response) => {
                this.listEquipos = response.data.equipos;
            });
        },
        cargaFile(key, event) {
            this.oRepuesto[key] = null;
            this.oRepuesto[key] = event.target.files[0];
        },
        setRegistro() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/repuestos";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                if (this.oRepuesto.codigo.trim() != "") {
                    formdata.append("codigo", this.oRepuesto.codigo);
                }
                if (this.oRepuesto.nombre.trim() != "") {
                    formdata.append("nombre", this.oRepuesto.nombre);
                }
                if (this.oRepuesto.descripcion.trim() != "") {
                    formdata.append("descripcion", this.oRepuesto.descripcion);
                }
                if (this.oRepuesto.marca.trim() != "") {
                    formdata.append("marca", this.oRepuesto.marca);
                }
                if (this.oRepuesto.modelo.trim() != "") {
                    formdata.append("modelo", this.oRepuesto.modelo);
                }
                if (this.oRepuesto.serie.trim() != "") {
                    formdata.append("serie", this.oRepuesto.serie);
                }
                if (this.oRepuesto.equipo_id) {
                    formdata.append("equipo_id", this.oRepuesto.equipo_id);
                }
                if (this.oRepuesto.precio.trim() != "") {
                    formdata.append("precio", this.oRepuesto.precio);
                }
                if (("" + this.oRepuesto.stock_min).trim() != "") {
                    formdata.append("stock_min", this.oRepuesto.stock_min);
                }
                if (("" + this.oRepuesto.stock_max).trim() != "") {
                    formdata.append("stock_max", this.oRepuesto.stock_max);
                }
                if (this.oRepuesto.unidad_medida.trim() != "") {
                    formdata.append(
                        "unidad_medida",
                        this.oRepuesto.unidad_medida
                    );
                }
                if (this.oRepuesto.dir.trim() != "") {
                    formdata.append("dir", this.oRepuesto.dir);
                }
                if (this.oRepuesto.fono.trim() != "") {
                    formdata.append("fono", this.oRepuesto.fono);
                }
                if (this.oRepuesto.correo.trim() != "") {
                    formdata.append("correo", this.oRepuesto.correo);
                }
                if (this.oRepuesto.almacen.trim() != "") {
                    formdata.append("almacen", this.oRepuesto.almacen);
                }
                if (this.oRepuesto.fabricante.trim() != "") {
                    formdata.append("fabricante", this.oRepuesto.fabricante);
                }
                if (this.oRepuesto.proveedor.trim() != "") {
                    formdata.append("proveedor", this.oRepuesto.proveedor);
                }
                if (this.oRepuesto.terciarios.trim() != "") {
                    formdata.append("terciarios", this.oRepuesto.terciarios);
                }
                if (this.oRepuesto.nombre_contacto.trim() != "") {
                    formdata.append(
                        "nombre_contacto",
                        this.oRepuesto.nombre_contacto
                    );
                }
                if (this.oRepuesto.num_fono.trim() != "") {
                    formdata.append("num_fono", this.oRepuesto.num_fono);
                }
                if (this.oRepuesto.correo_fabricante.trim() != "") {
                    formdata.append(
                        "correo_fabricante",
                        this.oRepuesto.correo_fabricante
                    );
                }
                if (this.oRepuesto.dir_fabricante.trim() != "") {
                    formdata.append(
                        "dir_fabricante",
                        this.oRepuesto.dir_fabricante
                    );
                }
                if (this.oRepuesto.num_identificacion.trim() != "") {
                    formdata.append(
                        "num_identificacion",
                        this.oRepuesto.num_identificacion
                    );
                }

                if (this.accion == "edit") {
                    url = "/admin/repuestos/" + this.oRepuesto.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.limpiaRepuesto();
                            this.$router.push({ name: "repuestos.index" });
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar";
                            } else {
                                this.textoBtn = "Registrar";
                            }
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        limpiaRepuesto() {
            this.errors = [];
            this.oRepuesto.codigo = "";
            this.oRepuesto.nombre = "";
            this.oRepuesto.descripcion = "";
            this.oRepuesto.marca = "";
            this.oRepuesto.modelo = "";
            this.oRepuesto.serie = "";
            this.oRepuesto.equipo_id = "";
            this.oRepuesto.precio = "";
            this.oRepuesto.stock_min = "";
            this.oRepuesto.stock_max = "";
            this.oRepuesto.unidad_medida = "";
            this.oRepuesto.dir = "";
            this.oRepuesto.fono = "";
            this.oRepuesto.correo = "";
            this.oRepuesto.almacen = "";
            this.oRepuesto.fabricante = "";
            this.oRepuesto.proveedor = "";
            this.oRepuesto.terciarios = "";
            this.oRepuesto.nombre_contacto = "";
            this.oRepuesto.num_fono = "";
            this.oRepuesto.correo_fabricante = "";
            this.oRepuesto.dir_fabricante = "";
            this.oRepuesto.num_identificacion = "";
        },
    },
};
</script>

<style></style>
