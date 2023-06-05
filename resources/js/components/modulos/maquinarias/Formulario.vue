<template>
    <div class="row">
        <div class="col-md-12">
            <form>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.equipo_id,
                            }"
                            >Seleccionar Equipo*</label
                        >
                        <el-select
                            placeholder="Equipo"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.equipo_id,
                            }"
                            v-model="oMaquinaria.equipo_id"
                            clearable
                        >
                            <el-option
                                v-for="item in listEquipos"
                                :key="item.id"
                                :value="item.id"
                                :label="
                                    item.codigo +
                                    ' | ' +
                                    item.nombre +
                                    ' | ' +
                                    item.area.nombre +
                                    ' | ' +
                                    item.sistema.nombre
                                "
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.equipo_id"
                            v-text="errors.equipo_id[0]"
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
                            v-model="oMaquinaria.descripcion"
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
                                'text-danger': errors.prioridad,
                            }"
                            >Prioridad*</label
                        >
                        <el-select
                            placeholder="Prioridad"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.prioridad,
                            }"
                            v-model="oMaquinaria.prioridad"
                            clearable
                        >
                            <el-option
                                v-for="(item, index) in listPrioridad"
                                :key="index"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.prioridad"
                            v-text="errors.prioridad[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.ubicacion,
                            }"
                            >Ubicación*</label
                        >
                        <el-select
                            placeholder="Ubicación"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.ubicacion,
                            }"
                            v-model="oMaquinaria.ubicacion"
                            clearable
                        >
                            <el-option
                                v-for="(item, index) in listUbicacion"
                                :key="index"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.ubicacion"
                            v-text="errors.ubicacion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.tipo,
                            }"
                            >Tipo*</label
                        >
                        <el-select
                            placeholder="Tipo"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.tipo,
                            }"
                            v-model="oMaquinaria.tipo"
                            clearable
                        >
                            <el-option
                                v-for="(item, index) in listTipo"
                                :key="index"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.tipo"
                            v-text="errors.tipo[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS BÁSICOS
                        </h3>
                    </div>
                    <hr class="col-md-12" />
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
                            v-model="oMaquinaria.marca"
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
                            v-model="oMaquinaria.modelo"
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
                            placeholder="Serie"
                            :class="{
                                'is-invalid': errors.serie,
                            }"
                            v-model="oMaquinaria.serie"
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
                            DATOS DE COMPRA
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.costo,
                            }"
                            >Costo de maquinaria</label
                        >
                        <el-input
                            placeholder="Costo de maquinaria"
                            :class="{
                                'is-invalid': errors.costo,
                            }"
                            v-model="oMaquinaria.costo"
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
                                'text-danger': errors.fecha_compra,
                            }"
                            >Fecha de compra</label
                        >
                        <input
                            type="date"
                            placeholder="Fecha de compra"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.fecha_compra,
                            }"
                            v-model="oMaquinaria.fecha_compra"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fecha_compra"
                            v-text="errors.fecha_compra[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.fecha_instalacion,
                            }"
                            >Fecha de instalación</label
                        >
                        <input
                            type="date"
                            placeholder="Fecha de instalación"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.fecha_instalacion,
                            }"
                            v-model="oMaquinaria.fecha_instalacion"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fecha_instalacion"
                            v-text="errors.fecha_instalacion[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.garantia_meses,
                            }"
                            >Garantía meses</label
                        >
                        <el-input
                            placeholder="Garantía meses"
                            :class="{
                                'is-invalid': errors.garantia_meses,
                            }"
                            v-model="oMaquinaria.garantia_meses"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.garantia_meses"
                            v-text="errors.garantia_meses[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS TÉCNICOS
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.peso,
                            }"
                            >Peso</label
                        >
                        <el-input
                            placeholder="Peso"
                            :class="{
                                'is-invalid': errors.peso,
                            }"
                            v-model="oMaquinaria.peso"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.peso"
                            v-text="errors.peso[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.altura,
                            }"
                            >Altura</label
                        >
                        <el-input
                            placeholder="Altura"
                            :class="{
                                'is-invalid': errors.altura,
                            }"
                            v-model="oMaquinaria.altura"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.altura"
                            v-text="errors.altura[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.ancho,
                            }"
                            >Ancho</label
                        >
                        <el-input
                            placeholder="Ancho"
                            :class="{
                                'is-invalid': errors.ancho,
                            }"
                            v-model="oMaquinaria.ancho"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.ancho"
                            v-text="errors.ancho[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.largo,
                            }"
                            >Largo</label
                        >
                        <el-input
                            placeholder="Largo"
                            :class="{
                                'is-invalid': errors.largo,
                            }"
                            v-model="oMaquinaria.largo"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.largo"
                            v-text="errors.largo[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.voltios,
                            }"
                            >Voltios</label
                        >
                        <el-input
                            placeholder="Voltios"
                            :class="{
                                'is-invalid': errors.voltios,
                            }"
                            v-model="oMaquinaria.voltios"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.voltios"
                            v-text="errors.voltios[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.capacidad,
                            }"
                            >Capacidad</label
                        >
                        <el-input
                            placeholder="Capacidad"
                            :class="{
                                'is-invalid': errors.capacidad,
                            }"
                            v-model="oMaquinaria.capacidad"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.capacidad"
                            v-text="errors.capacidad[0]"
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
                            v-model="oMaquinaria.e_tecnicas"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.e_tecnicas"
                            v-text="errors.e_tecnicas[0]"
                        ></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="card-title font-weight-bold">
                            DATOS DE MANTENIMIENTO
                        </h3>
                    </div>
                    <hr class="col-md-12" />
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger':
                                    errors.fecha_ultimo_mantenimiento,
                            }"
                            >Fecha de último mantenimiento</label
                        >
                        <input
                            type="date"
                            class="form-control"
                            placeholder="Fecha de último mantenimiento"
                            :class="{
                                'is-invalid': errors.fecha_ultimo_mantenimiento,
                            }"
                            v-model="oMaquinaria.fecha_ultimo_mantenimiento"
                            clearable
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fecha_ultimo_mantenimiento"
                            v-text="errors.fecha_ultimo_mantenimiento[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.fecha_utlimo_termino,
                            }"
                            >Fecha último de termino</label
                        >
                        <input
                            type="date"
                            class="form-control"
                            placeholder="Fecha último de termino"
                            :class="{
                                'is-invalid': errors.fecha_utlimo_termino,
                            }"
                            v-model="oMaquinaria.fecha_utlimo_termino"
                            clearable
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fecha_utlimo_termino"
                            v-text="errors.fecha_utlimo_termino[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.estado,
                            }"
                            >Estado*</label
                        >
                        <el-select
                            placeholder="Estado"
                            class="w-100"
                            :class="{
                                'is-invalid': errors.estado,
                            }"
                            v-model="oMaquinaria.estado"
                            clearable
                        >
                            <el-option
                                v-for="(item, index) in listEstado"
                                :key="index"
                                :value="item"
                                :label="item"
                            ></el-option>
                        </el-select>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.estado"
                            v-text="errors.estado[0]"
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
                                'text-danger': errors.fabricantes,
                            }"
                            >Fabricantes</label
                        >
                        <el-input
                            placeholder="Fabricantes"
                            :class="{
                                'is-invalid': errors.fabricantes,
                            }"
                            v-model="oMaquinaria.fabricantes"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.fabricantes"
                            v-text="errors.fabricantes[0]"
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
                            v-model="oMaquinaria.proveedor"
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
                            v-model="oMaquinaria.terciarios"
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
                            >Nombre de contacto</label
                        >
                        <el-input
                            placeholder="Nombre de contacto"
                            :class="{
                                'is-invalid': errors.nombre_contacto,
                            }"
                            v-model="oMaquinaria.nombre_contacto"
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
                            v-model="oMaquinaria.num_fono"
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
                                'text-danger': errors.correo,
                            }"
                            >Correo electrónico</label
                        >
                        <el-input
                            placeholder="Correo electrónico"
                            :class="{
                                'is-invalid': errors.correo,
                            }"
                            v-model="oMaquinaria.correo"
                            clearable
                        >
                        </el-input>
                        <span
                            class="error invalid-feedback"
                            v-if="errors.correo"
                            v-text="errors.correo[0]"
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
                            v-model="oMaquinaria.dir"
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
                                'text-danger': errors.num_identificacion,
                            }"
                            >Número de identificación</label
                        >
                        <el-input
                            placeholder="Número de identificación"
                            :class="{
                                'is-invalid': errors.num_identificacion,
                            }"
                            v-model="oMaquinaria.num_identificacion"
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
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.foto"
                            v-text="errors.foto[0]"
                        ></span>
                    </div>
                    <div class="form-group col-md-6">
                        <label
                            :class="{
                                'text-danger': errors.archivo,
                            }"
                            >Archivo (pdf)</label
                        >
                        <input
                            type="file"
                            placeholder="Foto"
                            class="form-control"
                            :class="{
                                'is-invalid': errors.archivo,
                            }"
                            ref="input_archivo"
                        />
                        <span
                            class="error invalid-feedback"
                            v-if="errors.archivo"
                            v-text="errors.archivo[0]"
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
        maquinaria: {
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
            oMaquinaria: this.maquinaria,
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
        setRegistro() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/maquinarias";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "equipo_id",
                    this.oMaquinaria.equipo_id ? this.oMaquinaria.equipo_id : ""
                );
                formdata.append(
                    "descripcion",
                    this.oMaquinaria.descripcion
                        ? this.oMaquinaria.descripcion
                        : ""
                );
                formdata.append(
                    "prioridad",
                    this.oMaquinaria.prioridad ? this.oMaquinaria.prioridad : ""
                );
                formdata.append(
                    "ubicacion",
                    this.oMaquinaria.ubicacion ? this.oMaquinaria.ubicacion : ""
                );
                formdata.append(
                    "tipo",
                    this.oMaquinaria.tipo ? this.oMaquinaria.tipo : ""
                );
                formdata.append(
                    "marca",
                    this.oMaquinaria.marca ? this.oMaquinaria.marca : ""
                );
                formdata.append(
                    "modelo",
                    this.oMaquinaria.modelo ? this.oMaquinaria.modelo : ""
                );
                formdata.append(
                    "serie",
                    this.oMaquinaria.serie ? this.oMaquinaria.serie : ""
                );
                formdata.append(
                    "costo",
                    this.oMaquinaria.costo ? this.oMaquinaria.costo : ""
                );
                formdata.append(
                    "fecha_compra",
                    this.oMaquinaria.fecha_compra
                        ? this.oMaquinaria.fecha_compra
                        : ""
                );
                formdata.append(
                    "fecha_instalacion",
                    this.oMaquinaria.fecha_instalacion
                        ? this.oMaquinaria.fecha_instalacion
                        : ""
                );
                formdata.append(
                    "garantia_meses",
                    this.oMaquinaria.garantia_meses
                        ? this.oMaquinaria.garantia_meses
                        : ""
                );
                formdata.append(
                    "peso",
                    this.oMaquinaria.peso ? this.oMaquinaria.peso : ""
                );
                formdata.append(
                    "altura",
                    this.oMaquinaria.altura ? this.oMaquinaria.altura : ""
                );
                formdata.append(
                    "ancho",
                    this.oMaquinaria.ancho ? this.oMaquinaria.ancho : ""
                );
                formdata.append(
                    "largo",
                    this.oMaquinaria.largo ? this.oMaquinaria.largo : ""
                );
                formdata.append(
                    "voltios",
                    this.oMaquinaria.voltios ? this.oMaquinaria.voltios : ""
                );
                formdata.append(
                    "capacidad",
                    this.oMaquinaria.capacidad ? this.oMaquinaria.capacidad : ""
                );
                formdata.append(
                    "e_tecnicas",
                    this.oMaquinaria.e_tecnicas
                        ? this.oMaquinaria.e_tecnicas
                        : ""
                );
                formdata.append(
                    "fecha_ultimo_mantenimiento",
                    this.oMaquinaria.fecha_ultimo_mantenimiento
                        ? this.oMaquinaria.fecha_ultimo_mantenimiento
                        : ""
                );
                formdata.append(
                    "fecha_utlimo_termino",
                    this.oMaquinaria.fecha_utlimo_termino
                        ? this.oMaquinaria.fecha_utlimo_termino
                        : ""
                );
                formdata.append(
                    "estado",
                    this.oMaquinaria.estado ? this.oMaquinaria.estado : ""
                );
                formdata.append(
                    "fabricantes",
                    this.oMaquinaria.fabricantes
                        ? this.oMaquinaria.fabricantes
                        : ""
                );
                formdata.append(
                    "proveedor",
                    this.oMaquinaria.proveedor ? this.oMaquinaria.proveedor : ""
                );
                formdata.append(
                    "terciarios",
                    this.oMaquinaria.terciarios
                        ? this.oMaquinaria.terciarios
                        : ""
                );
                formdata.append(
                    "nombre_contacto",
                    this.oMaquinaria.nombre_contacto
                        ? this.oMaquinaria.nombre_contacto
                        : ""
                );
                formdata.append(
                    "num_fono",
                    this.oMaquinaria.num_fono ? this.oMaquinaria.num_fono : ""
                );
                formdata.append(
                    "correo",
                    this.oMaquinaria.correo ? this.oMaquinaria.correo : ""
                );
                formdata.append(
                    "dir",
                    this.oMaquinaria.dir ? this.oMaquinaria.dir : ""
                );
                formdata.append(
                    "num_identificacion",
                    this.oMaquinaria.num_identificacion
                        ? this.oMaquinaria.num_identificacion
                        : ""
                );
                formdata.append(
                    "foto",
                    this.oMaquinaria.foto ? this.oMaquinaria.foto : ""
                );
                formdata.append(
                    "archivo",
                    this.oMaquinaria.archivo ? this.oMaquinaria.archivo : ""
                );

                if (this.accion == "edit") {
                    url = "/admin/maquinarias/" + this.oMaquinaria.id;
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
                            this.limpiaMaquinaria();
                            this.$emit("envioModal");
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
        limpiaMaquinaria() {
            this.errors = [];
            this.oMaquinaria.equipo_id = "";
            this.oMaquinaria.descripcion = "";
            this.oMaquinaria.prioridad = "";
            this.oMaquinaria.ubicacion = "";
            this.oMaquinaria.tipo = "";
            this.oMaquinaria.marca = "";
            this.oMaquinaria.modelo = "";
            this.oMaquinaria.serie = "";
            this.oMaquinaria.costo = "";
            this.oMaquinaria.fecha_compra = "";
            this.oMaquinaria.fecha_instalacion = "";
            this.oMaquinaria.garantia_meses = "";
            this.oMaquinaria.peso = "";
            this.oMaquinaria.altura = "";
            this.oMaquinaria.ancho = "";
            this.oMaquinaria.largo = "";
            this.oMaquinaria.voltios = "";
            this.oMaquinaria.capacidad = "";
            this.oMaquinaria.e_tecnicas = "";
            this.oMaquinaria.fecha_ultimo_mantenimiento = "";
            this.oMaquinaria.fecha_utlimo_termino = "";
            this.oMaquinaria.estado = "";
            this.oMaquinaria.fabricantes = "";
            this.oMaquinaria.proveedor = "";
            this.oMaquinaria.terciarios = "";
            this.oMaquinaria.nombre_contacto = "";
            this.oMaquinaria.num_fono = "";
            this.oMaquinaria.correo = "";
            this.oMaquinaria.dir = "";
            this.oMaquinaria.num_identificacion = "";
            this.oMaquinaria.foto = "";
            this.oMaquinaria.archivo = "";
        },
    },
};
</script>

<style></style>
