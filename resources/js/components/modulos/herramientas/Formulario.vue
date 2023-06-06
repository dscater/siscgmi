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
                            v-model="oHerramienta.codigo"
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
                            v-model="oHerramienta.nombre"
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
                            v-model="oHerramienta.descripcion"
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
                                'text-danger': errors.clasificacion,
                            }"
                            >Clasificación</label
                        >
                        <el-input
                            placeholder="Clasificación"
                            :class="{
                                'is-invalid': errors.clasificacion,
                            }"
                            v-model="oHerramienta.clasificacion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.clasificacion"
                            v-text="errors.clasificacion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.cod_clasificacion,
                            }"
                            >Código de clasificación</label
                        >
                        <el-input
                            placeholder="Código"
                            :class="{
                                'is-invalid': errors.cod_clasificacion,
                            }"
                            v-model="oHerramienta.cod_clasificacion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.cod_clasificacion"
                            v-text="errors.cod_clasificacion[0]"
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
                            v-model="oHerramienta.marca"
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
                            v-model="oHerramienta.modelo"
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
                            v-model="oHerramienta.serie"
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
                            DATOS DE INVENTARIO
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.costo,
                            }"
                            >Costo unitario</label
                        >
                        <el-input
                            type="number"
                            placeholder="Costo unitario"
                            :class="{
                                'is-invalid': errors.costo,
                            }"
                            v-model="oHerramienta.costo"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.costo"
                            v-text="errors.costo[0]"
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
                            v-model="oHerramienta.unidad_medida"
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
                                'text-danger': errors.proveedor,
                            }"
                            >Proveedor*</label
                        >
                        <el-input
                            placeholder="Proveedor"
                            :class="{
                                'is-invalid': errors.proveedor,
                            }"
                            v-model="oHerramienta.proveedor"
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
                                'text-danger': errors.dir,
                            }"
                            >Dirección</label
                        >
                        <el-input
                            placeholder="Dirección"
                            :class="{
                                'is-invalid': errors.dir,
                            }"
                            v-model="oHerramienta.dir"
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
                            v-model="oHerramienta.fono"
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
                            v-model="oHerramienta.correo"
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
                            v-model="oHerramienta.almacen"
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
                            v-model="oHerramienta.fabricante"
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
                                'text-danger': errors.terciarios,
                            }"
                            >Terciarios</label
                        >
                        <el-input
                            placeholder="Terciarios"
                            :class="{
                                'is-invalid': errors.terciarios,
                            }"
                            v-model="oHerramienta.terciarios"
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
                            v-model="oHerramienta.nombre_contacto"
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
                            v-model="oHerramienta.num_fono"
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
                            v-model="oHerramienta.correo_fabricante"
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
                            v-model="oHerramienta.dir_fabricante"
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
                            v-model="oHerramienta.num_identificacion"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.num_identificacion"
                            v-text="errors.num_identificacion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.e_tecnicas,
                            }"
                            >Especificaciones técnicas</label
                        >
                        <el-input
                            type="textarea"
                            autosize
                            placeholder="Especificaciones técnicas"
                            :class="{
                                'is-invalid': errors.e_tecnicas,
                            }"
                            v-model="oHerramienta.e_tecnicas"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.e_tecnicas"
                            v-text="errors.e_tecnicas[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.foto,
                            }"
                            >Foto</label
                        >
                        <input
                            type="file"
                            placeholder="Foto"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.foto,
                            }"
                            ref="input_foto"
                            @change="cargaFile('foto', $event)"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.foto"
                            v-text="errors.foto[0]"
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
        herramienta: {
            type: Object,
            default: {
                id: 0,
                equipo_id: "",
                descripcion: "",
                prioridad: "",
                ubicacion: "",
                tipo: "",
                marca: "",
                modelo: "",
                serie: "",
                costo: "",
                fecha_compra: "",
                fecha_instalacion: "",
                garantia_meses: "",
                peso: "",
                altura: "",
                ancho: "",
                largo: "",
                voltios: "",
                capacidad: "",
                e_tecnicas: "",
                fecha_ultimo_mantenimiento: "",
                fecha_utlimo_termino: "",
                estado: "",
                fabricantes: "",
                proveedor: "",
                terciarios: "",
                nombre_contacto: "",
                num_fono: "",
                correo: "",
                dir: "",
                num_identificacion: "",
                foto: "",
                archivo: "",
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
        herramienta(newVal) {
            this.oHerramienta = newVal;
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
            oHerramienta: this.herramienta,
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
            this.oHerramienta[key] = null;
            this.oHerramienta[key] = event.target.files[0];
        },
        setRegistro() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/herramientas";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                if (this.oHerramienta.codigo.trim() != "") {
                    formdata.append("codigo", this.oHerramienta.codigo);
                }
                if (this.oHerramienta.nombre.trim() != "") {
                    formdata.append("nombre", this.oHerramienta.nombre);
                }
                if (this.oHerramienta.descripcion.trim() != "") {
                    formdata.append(
                        "descripcion",
                        this.oHerramienta.descripcion
                    );
                }
                if (this.oHerramienta.clasificacion.trim() != "") {
                    formdata.append(
                        "clasificacion",
                        this.oHerramienta.clasificacion
                    );
                }
                if (this.oHerramienta.cod_clasificacion.trim() != "") {
                    formdata.append(
                        "cod_clasificacion",
                        this.oHerramienta.cod_clasificacion
                    );
                }
                if (this.oHerramienta.marca.trim() != "") {
                    formdata.append("marca", this.oHerramienta.marca);
                }
                if (this.oHerramienta.modelo.trim() != "") {
                    formdata.append("modelo", this.oHerramienta.modelo);
                }
                if (this.oHerramienta.serie.trim() != "") {
                    formdata.append("serie", this.oHerramienta.serie);
                }
                if (this.oHerramienta.costo.trim() != "") {
                    formdata.append("costo", this.oHerramienta.costo);
                }
                if (this.oHerramienta.unidad_medida.trim() != "") {
                    formdata.append(
                        "unidad_medida",
                        this.oHerramienta.unidad_medida
                    );
                }
                if (this.oHerramienta.proveedor.trim() != "") {
                    formdata.append("proveedor", this.oHerramienta.proveedor);
                }
                if (this.oHerramienta.dir.trim() != "") {
                    formdata.append("dir", this.oHerramienta.dir);
                }
                if (this.oHerramienta.fono.trim() != "") {
                    formdata.append("fono", this.oHerramienta.fono);
                }
                if (this.oHerramienta.correo.trim() != "") {
                    formdata.append("correo", this.oHerramienta.correo);
                }
                if (this.oHerramienta.almacen.trim() != "") {
                    formdata.append("almacen", this.oHerramienta.almacen);
                }
                if (this.oHerramienta.fabricante.trim() != "") {
                    formdata.append("fabricante", this.oHerramienta.fabricante);
                }
                if (this.oHerramienta.terciarios.trim() != "") {
                    formdata.append("terciarios", this.oHerramienta.terciarios);
                }
                if (this.oHerramienta.nombre_contacto.trim() != "") {
                    formdata.append(
                        "nombre_contacto",
                        this.oHerramienta.nombre_contacto
                    );
                }
                if (this.oHerramienta.num_fono.trim() != "") {
                    formdata.append("num_fono", this.oHerramienta.num_fono);
                }
                if (this.oHerramienta.correo_fabricante.trim() != "") {
                    formdata.append(
                        "correo_fabricante",
                        this.oHerramienta.correo_fabricante
                    );
                }
                if (this.oHerramienta.dir_fabricante.trim() != "") {
                    formdata.append(
                        "dir_fabricante",
                        this.oHerramienta.dir_fabricante
                    );
                }
                if (this.oHerramienta.num_identificacion.trim() != "") {
                    formdata.append(
                        "num_identificacion",
                        this.oHerramienta.num_identificacion
                    );
                }
                if (this.oHerramienta.e_tecnicas.trim() != "") {
                    formdata.append("e_tecnicas", this.oHerramienta.e_tecnicas);
                }

                if (this.oHerramienta.foto) {
                    formdata.append("foto", this.oHerramienta.foto);
                }

                if (this.accion == "edit") {
                    url = "/admin/herramientas/" + this.oHerramienta.id;
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
                            this.limpiaHerramienta();
                            this.$router.push({ name: "herramientas.index" });
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
        limpiaHerramienta() {
            this.errors = [];
            this.oHerramienta.equipo_id = "";
            this.oHerramienta.descripcion = "";
            this.oHerramienta.prioridad = "";
            this.oHerramienta.ubicacion = "";
            this.oHerramienta.tipo = "";
            this.oHerramienta.marca = "";
            this.oHerramienta.modelo = "";
            this.oHerramienta.serie = "";
            this.oHerramienta.costo = "";
            this.oHerramienta.fecha_compra = "";
            this.oHerramienta.fecha_instalacion = "";
            this.oHerramienta.garantia_meses = "";
            this.oHerramienta.peso = "";
            this.oHerramienta.altura = "";
            this.oHerramienta.ancho = "";
            this.oHerramienta.largo = "";
            this.oHerramienta.voltios = "";
            this.oHerramienta.capacidad = "";
            this.oHerramienta.e_tecnicas = "";
            this.oHerramienta.fecha_ultimo_mantenimiento = "";
            this.oHerramienta.fecha_utlimo_termino = "";
            this.oHerramienta.estado = "";
            this.oHerramienta.fabricantes = "";
            this.oHerramienta.proveedor = "";
            this.oHerramienta.terciarios = "";
            this.oHerramienta.nombre_contacto = "";
            this.oHerramienta.num_fono = "";
            this.oHerramienta.correo = "";
            this.oHerramienta.dir = "";
            this.oHerramienta.num_identificacion = "";
            this.oHerramienta.foto = "";
            this.oHerramienta.archivo = "";
        },
    },
};
</script>

<style></style>
